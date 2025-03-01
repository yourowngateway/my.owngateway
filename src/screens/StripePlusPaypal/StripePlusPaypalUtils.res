open QuickStartUtils
type step = STRIPE_CONFIGURE | PAYPAL_CONFIGURE | TEST_PAYMENT | COMPLETED_STRIPE_PAYPAL

let variantToEnumMapper = variantValue => {
  switch variantValue {
  | STRIPE_CONFIGURE => #StripeConnected
  | PAYPAL_CONFIGURE => #PaypalConnected
  | TEST_PAYMENT => #SPTestPayment
  | COMPLETED_STRIPE_PAYPAL => #StripeConnected
  }
}

let enumToValueMapper = (variantValue, typedValue: QuickStartTypes.responseType) => {
  switch variantValue {
  | STRIPE_CONFIGURE => typedValue.stripeConnected.processorID->LogicUtils.isNonEmptyString
  | PAYPAL_CONFIGURE => typedValue.paypalConnected.processorID->LogicUtils.isNonEmptyString
  | TEST_PAYMENT => typedValue.sPTestPayment
  | COMPLETED_STRIPE_PAYPAL => true
  }
}

let getSidebarOptionsForStripePayalIntegration: (
  string,
  step,
) => array<HSSelfServeSidebar.sidebarOption> = (enumDetails, spPageState) => {
  // TODO:Refactor code to more dynamic cases

  let currentPageStateEnum = spPageState->variantToEnumMapper

  open LogicUtils
  let enumValue = enumDetails->safeParse->getTypedValueFromDict

  [
    {
      title: "Setup Stripe Processor",
      status: String(enumValue.stripeConnected.processorID)->getStatusValue(
        #StripeConnected,
        currentPageStateEnum,
      ),
      link: "",
    },
    {
      title: "Setup PayPal Processor",
      status: String(enumValue.paypalConnected.processorID)->getStatusValue(
        #PaypalConnected,
        currentPageStateEnum,
      ),
      link: "",
    },
    {
      title: "Try OwnGateway checkout",
      status: Boolean(enumValue.sPTestPayment)->getStatusValue(
        #sPTestPayment,
        currentPageStateEnum,
      ),
      link: "",
    },
  ]
}
