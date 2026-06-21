<script setup lang="ts">
const siteUrl = 'https://andrewbilenduke.com'
const title = 'Andrew Bilenduke — Senior Full-Stack Engineer'
const description
  = 'Senior full-stack engineer with 11+ years building production web applications. '
  + 'Deep Vue.js expertise, Laravel APIs, Docker, Azure, accessibility, and CI/CD. '
  + 'Based in New England — open to relocation.'
const ogImage = `${siteUrl}/og-image.png`

useSeoMeta({
  title,
  description,
  ogTitle: title,
  ogDescription: description,
  ogType: 'website',
  ogUrl: `${siteUrl}/`,
  ogSiteName: 'Andrew Bilenduke',
  ogImage,
  ogImageWidth: 1200,
  ogImageHeight: 630,
  ogImageAlt: title,
  ogImageType: 'image/png',
  twitterCard: 'summary_large_image',
  twitterTitle: title,
  twitterDescription: description,
  twitterImage: ogImage,
})

// Person / structured data — helps Google identify the entity and link profiles.
const personLd = {
  '@context': 'https://schema.org',
  '@type': 'Person',
  name: 'Andrew Bilenduke',
  url: `${siteUrl}/`,
  jobTitle: 'Senior Full-Stack Engineer',
  image: `${siteUrl}/assets/andrew.jpg`,
  description,
  sameAs: [
    'https://github.com/ABilenduke',
    'https://www.linkedin.com/in/andrew-bilenduke-8633118a',
  ],
  knowsAbout: [
    'Vue.js', 'Nuxt', 'Laravel', 'TypeScript', 'Docker', 'Azure',
    'CI/CD', 'Web Accessibility (WCAG)', 'PostgreSQL', 'Redis',
  ],
  address: {
    '@type': 'PostalAddress',
    addressRegion: 'New England',
    addressCountry: 'US',
  },
}

useHead({
  link: [{ rel: 'canonical', href: `${siteUrl}/` }],
  meta: [
    { name: 'theme-color', content: '#fbfcfe', media: '(prefers-color-scheme: light)' },
    { name: 'theme-color', content: '#0b1222', media: '(prefers-color-scheme: dark)' },
  ],
  script: [{ type: 'application/ld+json', innerHTML: JSON.stringify(personLd) }],
})
</script>

<template>
  <main id="main" tabindex="-1">
    <HeroSection />
    <SpecializationStrip />
    <FeaturedProjects />
    <EngineeringApproach />
    <TechStack />
    <ExperienceOutcomes />
    <ExperienceTimeline />
    <AboutPreview />
    <ContactCTA />
  </main>
</template>
