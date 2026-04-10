#import "../lib.typ": *

#show: en-coverletter.with(
  author: (
    firstname: "John",
    lastname: "Smith",
    email: "js@example.com",
    phone: "(+1) 111-111-1111",
    github: "johnsmith",
    linkedin: "johnsmith",
    address: "123 Main St, Example City, EX 11111",
    positions: (
      "Software Engineer",
      "Full Stack Developer",
    ),
  ),
  language: "en",
  show-footer: true,
)

#hiring-entity-info(
  entity-info: (
    target: "Hiring Manager",
    name: "Acme Corp",
    street-address: "456 Tech Blvd",
    city: "San Francisco, CA 94105",
  ),
)

#letter-heading(job-position: "Senior Software Engineer", addressee: "Sir or Madam")

= About Me

I am a software engineer with over 5 years of experience building scalable distributed systems. My background spans full-stack development, cloud infrastructure, and team leadership.

= Why Acme Corp?

I am drawn to Acme Corp's mission to democratize developer tooling. Your recent open-source contributions to the cloud-native ecosystem align perfectly with my professional interests and values.

= Why Me?

My track record of reducing system latency by 40% and building data pipelines processing millions of events daily demonstrates my ability to deliver high-impact results. I am excited to bring this experience to your engineering team.
