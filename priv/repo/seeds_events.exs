alias PhoenixApp.Repo
alias PhoenixApp.Events.Event

Repo.insert!(%Event{
  name: "JAM0",
  short: "Implementor meetup near Sub0 and Devcon in Bangkok.",
  long: """
  Meetup for JAM implementors in Bangkok.
  Organized and sponsored by by [0](Colorful Notion) after Polkadot OpenGov proposal [1](#1024) was rejected. Sign-up and updates happen in this [2](Matrix chanel).
  """,
  links: ["https://colorfulnotion.com/", "https://polkadot.subsquare.io/referenda/1024", "https://app.element.io/#/room/!KKOmuUpvYKPcniwOzw:matrix.org"],
  learn_more_id: 1, # What link index to pick for the "Learn more" button.
  contact: [],
  when_from: ~D[2024-11-09],
  when_to: ~D[2024-11-16],
  where: "Valia Hotel, Bangkok, Thailand",
  where_link: "https://maps.app.goo.gl/oJCtRg9C3UWQgtmE6",
  historic: true
})

Repo.insert!(%Event{
  name: "JAM Meetup",
  short: "Implementor meetup and tour of the JAM toaster.",
  long: """
  This event is currently being planned. Make sure to join the [0](Matrix chat) for updates.

  Highlights are to see the Polkadot Palace and the JAM toaster. Otherwise opportunities to network and collaborate with other JAM implementors.
  """,
  links: ["https://app.element.io/#/room/!KKOmuUpvYKPcniwOzw:matrix.org"],
  contact: [],
  when_est: "March, 2025",
  where: "Cascais, Portugal",
  where_link: "https://maps.app.goo.gl/rdZQDbF7TtKeaHd2A",
  duration: "3 days",
})
