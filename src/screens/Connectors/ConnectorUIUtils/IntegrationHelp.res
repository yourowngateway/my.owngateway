module Render = {
  @react.component
  let make = (~connector, ~showModal, ~setShowModal) => {
    let {globalUIConfig: {font: {textColor}}} = React.useContext(ConfigContext.configContext)
    let integrationSteps = switch connector->ConnectorUtils.getConnectorNameTypeFromString() {
    | Processors(STRIPE) =>
      <div className="">
        <ol className="list-decimal pl-4">
          <li className="mb-8">
            {React.string("In your Stripe Dashboard home page, Click on the ")}
            <span className="font-bold"> {React.string("\"Developers\"")} </span>
            {React.string(" tab (top-right of the dashboard) and navigate to ")}
            <span className="font-bold"> {React.string("\"API Keys\"")} </span>
            {React.string(" section")}
            <a href={`/icons/stripe_apikey.png`} target="_blank">
              <img
                className="m-4 border rounded-lg border-gray-200"
                style={ReactDOMStyle.make(~maxWidth="94%", ())}
                src={`/icons/stripe_apikey.png`}
              />
            </a>
          </li>
          <li className="mb-8">
            {React.string(
              "Copy the Secret and Public keys and add them to the OwnGateway dashboard under Stripe",
            )}
          </li>
        </ol>
        <div className="p-8 my-4 bg-amber-100/75 border rounded-lg font-medium border-transparent ">
          {React.string(
            "Note: For Stripe to directly accept card on the account, make the following changes:",
          )}
          <ul className="list-disc mt-4 ml-4">
            <li className="mb-4">
              {React.string("Search for ")}
              <span className="font-bold">
                {React.string("Integrations > Advanced Options > Handle card information directly")}
              </span>
            </li>
            <li className="mb-4">
              {React.string(
                "Currently, OwnGateway supports the latest Payments Intent APIs of Stripe API that is created after 2019",
              )}
            </li>
            <li className="mb-4">
              {React.string(
                "If the 'Handle card information directly' toggle cannot be turned on, please refer to this ",
              )}
              <a
                className={`${textColor.primaryNormal} underline`}
                href="https://support.stripe.com/questions/enabling-access-to-raw-card-data-apis"
                target="_blank">
                {React.string("link")}
              </a>
            </li>
          </ul>
        </div>
        <a href={`/icons/stripe_helper.png`} target="_blank">
          <img
            className="m-4 border rounded-lg border-gray-200"
            style={ReactDOMStyle.make(~maxWidth="94%", ())}
            src={`/icons/stripe_helper.png`}
          />
        </a>
      </div>
    | Processors(ADYEN) =>
      <div className="">
        <ol className="list-decimal pl-4">
          <li className="mb-8">
            {React.string("In your Adyen Dashboard, Click on the ")}
            <span className="font-bold"> {React.string("\"Developers\"")} </span>
            {React.string(" tab and navigate to API credentials.")}
            <a href={`/icons/adyen_apikey.png`} target="_blank">
              <img
                className="m-4 border rounded-lg border-gray-200" src={`/icons/adyen_apikey.png`}
              />
            </a>
          </li>
          <li className="mb-4">
            {React.string(
              "Copy the API key and Merchant Account ID and add them to the OwnGateway dashboard under Adyen.",
            )}
          </li>
        </ol>
        <div
          className="py-6 px-4 m-8 my-2 bg-amber-100/75 border rounded-lg font-medium border-transparent">
          {React.string("For making card payment via Adyen, you need to enable full card payments.
              You would have to contact the Adyen customer support and ask them to enable it for you for testing payments.")}
        </div>
        <a href={`/icons/adyen_merchantID.png`} target="_blank">
          <img
            className="m-8 border rounded-lg border-gray-200 w-3/4"
            src={`/icons/adyen_merchantID.png`}
          />
        </a>
        <div className="flex flex-col items-center text-sm text-gray-400">
          {React.string("Click on the top-right corner to find your Merchant ID.")}
        </div>
      </div>
    | Processors(CHECKOUT) =>
      <div className="">
        <ol className="list-decimal pl-4">
          <li className="mb-8">
            {React.string("In your Stripe Dashboard home page, Click on ")}
            <span className="font-bold"> {React.string("Developers > Keys")} </span>
            {React.string(" . Click on the active access key in the \"Access Keys\" table.")}
          </li>
          <li className="mb-8">
            {React.string(
              "Click on Update key (top-right). In the Processing channels section copy the Channel ID and add them to OwnGateway dashboard under Checkout",
            )}
          </li>
          <li className="mb-8">
            {React.string("Use the Public key and Secret key generated during the creation of the Checkout's API key and add them to the OwnGateway dashboard. 
                For the hint about the key Click on the Developer tab and navigate to Keys")}
          </li>
        </ol>
        <div
          className="py-6 px-4 m-8 my-2 bg-amber-100/75 border rounded-lg font-medium border-transparent">
          {React.string("For making card payment via Checkout, you need to enable full card payments. 
               You would have to contact the checkout.com customer support and ask them to enable it for you for testing payments.")}
        </div>
        <div className="mt-8 italic">
          {React.string("Note: Secret key is displayed only once during the key creation. 
              New Checkout Public key and Secret key can be created in Developers > Keys > Create a new key.")}
        </div>
      </div>
    | Processors(PAYPAL) =>
      <div className="">
        <ol className="list-decimal pl-4">
          <li className="mb-8">
            {React.string("In your Paypal Sandbox account, Click on the  ")}
            <span className="font-bold"> {React.string("\"Developer Dashboard\"")} </span>
            {React.string(" and navigate to ")}
            <span className="font-bold"> {React.string("\"API credentials\"")} </span>
            {React.string(" tab ")}
            <a
              className={`$ underline`}
              href="https://developer.paypal.com/dashboard/applications/sandbox"
              target="_blank">
              {React.string("here")}
            </a>
          </li>
          <li className="mb-8">
            {React.string(
              "Copy the ClientID, Client Secret of the App name used under the REST API apps",
            )}
            <a href={`/icons/paypal_apikey.png`} target="_blank">
              <img
                className="m-4 border rounded-lg border-gray-200"
                style={ReactDOMStyle.make(~maxWidth="94%", ())}
                src={`/icons/paypal_apikey.png`}
              />
            </a>
          </li>
        </ol>
      </div>
    | _ => React.null
    }
    <Modal
      modalHeading={`Steps to integrate ${connector->LogicUtils.snakeToTitle}`}
      headerTextClass={`${textColor.primaryNormal}  font-bold text-xl`}
      showModal
      setShowModal
      paddingClass=""
      revealFrom=Reveal.Right
      modalClass="w-1/3 !h-full overflow-scroll rounded-none text-jp-gray-900">
      integrationSteps
    </Modal>
  }
}
