alias PhoenixApp.Repo
alias PhoenixApp.Events.Event

Repo.insert!(%Event{
  name: "JAM0",
  description: "Implementor meetup near Sub0 and Devcon in Bangkok.",
  links: ["https://polkadot.subsquare.io/referenda/1024"],
  contact: [],
  when_from: ~D[2024-11-09],
  when_to: ~D[2024-11-16],
  where: "Valia Hotel, Bangkok, Thailand"
})
