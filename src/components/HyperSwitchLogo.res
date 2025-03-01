type theme = Light | Dark

@react.component
let make = (
  ~logoClass="",
  ~handleClick=?,
  ~logoVariant=CommonAuthTypes.IconWithText,
  ~logoHeight="h-6",
  ~theme=Dark,
  ~iconUrl=None,
) => {
  let iconFolder = switch theme {
  | Dark => "Dark"
  | Light => "Light"
  }

  let handleClickEvent = ev => {
    switch handleClick {
    | Some(fn) => fn(ev)
    | None => ()
    }
  }

  let iconImagePath = switch logoVariant {
  | Icon => `/assets/${iconFolder}/owngatewayLogoIcon.png`
  | Text => `/assets/${iconFolder}/owngatewayLogoText.svg`
  | IconWithText => `/assets/${iconFolder}/owngatewayLogoIconWithText.svg`
  | IconWithURL => `${iconUrl->Option.getOr("")}`
  }

  <div className={`${logoClass}`} onClick={handleClickEvent}>
    <img src=iconImagePath className=logoHeight />
  </div>
}
