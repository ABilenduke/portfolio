<script setup lang="ts">
const description
  = 'Senior full-stack engineer with 11+ years building production web applications. '
  + 'Deep Vue.js expertise, Laravel APIs, Docker, Azure, accessibility, and CI/CD. '
  + 'Based in New England — open to relocation.'

useSeoMeta({
  title: 'Andrew Bilenduke — Senior Full-Stack Engineer',
  description,
  ogTitle: 'Andrew Bilenduke — Senior Full-Stack Engineer',
  ogDescription: description,
  ogType: 'website',
  twitterCard: 'summary_large_image',
  twitterTitle: 'Andrew Bilenduke — Senior Full-Stack Engineer',
  twitterDescription: description,
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
