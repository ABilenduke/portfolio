<script setup lang="ts">
import { ArrowRight, ChevronDown } from 'lucide-vue-next'

const { open: openContact } = useContactModal()

const jobs = [
  {
    company: 'ITR Economics / Crowe',
    role: 'Senior Software Engineer',
    where: 'Manchester, NH (Remote)',
    when: 'Mar 2023 – Present',
    bullets: [
      'Migrated a legacy Blade application to a full Vue 3 SPA (Inertia.js + Pinia), modernizing 50+ views and ~50k LOC without a disruptive rewrite — improved key page loads by ~35%.',
      'Drove Veracode security scan results to 100%, closing every finding across the codebase as part of a security audit.',
      'Established the testing culture from zero — Vitest, Pest, Playwright E2E (Sauce Labs through CI). Lifted meaningful coverage from ~3% to ~38%, including 15 critical user journeys under E2E.',
      'Rebuilt the deployment pipeline with Docker, Docker Compose, Bash tooling, and Azure. Cut deploy time from 2–4 hours to under 40 minutes (~70% reduction); release cadence monthly → multiple per week.',
      'Reduced new developer onboarding from 1–2 days to under an hour via containerized local development.',
      'Migrated CSS architecture from SCSS to PostCSS; made the application fully responsive and WCAG-compliant — both significant gaps when I joined.',
      'Mentor 3–4 developers on Vue, testing, Docker, code review. Lead peer review and contribute to architectural decisions.',
    ],
    stack: ['Laravel', 'Vue 3', 'Inertia.js', 'Pinia', 'PostgreSQL', 'Redis', 'PostCSS', 'Docker', 'Azure', 'Vitest', 'Pest', 'Playwright'],
  },
  {
    company: 'Pleora Technologies',
    role: 'Full Stack Developer',
    where: 'Kanata, ON (Remote)',
    when: 'Oct 2021 – Jan 2023',
    bullets: [
      'Hired to bring Vue.js expertise to a defect-detection application for assembly line operators — live camera feeds and AI inference results in a locally-deployed UI.',
      "Both prior developers (neither frontend specialists) departed within two weeks of my start. Under a tight deadline, shipped v1, then rebuilt against Vue's idiomatic patterns.",
      'Introduced Redis as cache and persistent store for the local-deployment, low-latency requirements.',
      'Restored the codebase to a state where new hires could ramp up and contribute meaningfully within their first week.',
    ],
    stack: ['Python (Flask)', 'Vue.js', 'SCSS', 'Redis', 'MongoDB', 'Docker'],
  },
  {
    company: 'Lole Brands',
    role: 'Full Stack Developer',
    where: 'Montréal, QC (Remote)',
    when: 'Jul 2020 – Oct 2021',
    bullets: [
      'Led full accessibility remediation following an ADA-related lawsuit. Screen reader support, full keyboard navigation (including complex data tables), WCAG color contrast, ARIA semantics across the e-commerce platform.',
      'Identified and resolved blocking issues to support the launch of a new e-commerce site.',
      'Developed and shipped new features through to production.',
    ],
    stack: ['Ruby on Rails', 'Node.js', 'Vue.js', 'GraphQL', 'Sass', 'Shopify', 'Docker', 'Azure'],
  },
  {
    company: 'Alayacare',
    role: 'Full Stack Developer',
    where: 'Montréal, QC',
    when: 'Nov 2019 – May 2020',
    bullets: [
      'Collaborated with product and engineering teams to extend an existing healthcare platform with new features.',
      'Engaged in requirements analysis, technical planning, and full-stack implementation.',
    ],
    stack: ['Python (Flask)', 'Vue.js', 'Node.js', 'PostgreSQL', 'MySQL', 'Sass', 'Docker'],
  },
  {
    company: 'Dynamo Media',
    role: 'Full Stack Developer',
    where: 'Montréal, QC',
    when: 'Nov 2018 – Nov 2019',
    bullets: [
      'Maintained and modernized legacy applications, identified and resolved security vulnerabilities, and built new projects from scratch using current frameworks and tooling.',
    ],
    stack: ['PHP (Laravel, CakePHP, Joomla)', 'Python', 'Vue.js', 'Node.js', 'MySQL', 'Docker'],
  },
  {
    company: 'Momentum Travel Group',
    role: 'Full Stack Developer',
    where: 'Montréal, QC',
    when: 'Feb 2018 – Sep 2018',
    bullets: [
      'Revived a scrapped project, brought it to production, and shipped ongoing features and bug fixes.',
    ],
    stack: ['PHP (Laravel, SolarPHP)', 'Vue.js', 'Node.js', 'Sass', 'MySQL'],
  },
  {
    company: 'Canada Revenue Agency',
    role: 'Full Stack Developer',
    where: 'Ottawa, ON',
    when: 'Jul 2016 – Oct 2017',
    bullets: [
      'Implemented new tax legislation in the disbursement tracking system. Worked closely with stakeholders to translate regulatory requirements into working code.',
    ],
    stack: ['COBOL', 'Java'],
  },
  {
    company: 'Kubra Data Transfer',
    role: 'Technical Client Support Analyst',
    where: 'Mississauga, ON',
    when: 'Apr 2015 – Jul 2016',
    bullets: [
      'Worked directly with enterprise clients to implement data solutions, troubleshoot integration issues, and produce analytics reports via custom SQL queries.',
    ],
    stack: ['.NET (C#, VB, ASP.NET)', 'JavaScript', 'CSS', 'Microsoft SQL Server'],
  },
]

// Each row toggles independently; first row open by default.
const openRows = ref<boolean[]>(jobs.map((_, i) => i === 0))
function toggle(i: number) {
  openRows.value[i] = !openRows.value[i]
}
const pad = (n: number) => String(n).padStart(2, '0')
</script>

<template>
  <section id="experience" class="section">
    <div class="container">
      <div class="section-head">
        <div class="left">
          <span class="eyebrow tl__eyebrow">05 — experience</span>
          <h2 class="h2 tl__title">Eleven years, eight engagements.</h2>
          <p class="body-p tl__intro">
            Product engineering, agency work, and one stint at a federal tax agency. The thread:
            showing up to a codebase, understanding what's actually there, and quietly making it
            better.
          </p>
        </div>
        <button type="button" class="link-arrow tl__cta" @click="openContact()">
          Get in touch
          <ArrowRight :size="14" />
        </button>
      </div>

      <div class="tl__list">
        <div v-for="(job, i) in jobs" :key="job.company" class="card job">
          <button
            type="button"
            class="job__header"
            :aria-expanded="openRows[i]"
            :aria-controls="`job-detail-${i}`"
            @click="toggle(i)"
          >
            <div class="job__num">{{ pad(i + 1) }}</div>
            <div class="job__id">
              <h3 class="h3 job__role">
                {{ job.role }} · <span class="job__company">{{ job.company }}</span>
              </h3>
              <div class="job__where">{{ job.where }}</div>
            </div>
            <div class="job__when">{{ job.when }}</div>
            <div class="job__chev" :class="{ open: openRows[i] }">
              <ChevronDown :size="14" />
            </div>
          </button>

          <div v-if="openRows[i]" :id="`job-detail-${i}`" class="job__detail">
            <ul class="job__bullets">
              <li v-for="(b, bi) in job.bullets" :key="bi" class="job__bullet">
                <span class="job__dash">—</span>
                <span>{{ b }}</span>
              </li>
            </ul>
            <div class="job__stack">
              <span v-for="s in job.stack" :key="s" class="pill pill-plain">{{ s }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.tl__eyebrow { margin-bottom: 18px; }
.tl__title { margin-top: 18px; }
.tl__intro { margin-top: 10px; }
.tl__cta {
  background: none;
  border: none;
  cursor: pointer;
  font: inherit;
}

.tl__list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.job {
  padding: 0;
  overflow: hidden;
}
.job__header {
  background: transparent;
  border: none;
  width: 100%;
  text-align: left;
  padding: 24px 28px;
  cursor: pointer;
  display: grid;
  grid-template-columns: auto 1fr auto auto;
  gap: 24px;
  align-items: center;
  color: inherit;
  font-family: inherit;
}
.job__num {
  font-family: var(--font-mono);
  font-size: 13px;
  color: var(--fg-3);
  letter-spacing: 0.06em;
  min-width: 32px;
}
.job__id {
  display: flex;
  flex-direction: column;
  gap: 4px;
  min-width: 0;
}
.job__role {
  font-size: 19px;
  line-height: 1.3;
}
.job__company {
  color: var(--fg-2);
  font-weight: 500;
}
.job__where {
  font-family: var(--font-mono);
  font-size: 12.5px;
  color: var(--fg-3);
  letter-spacing: 0.02em;
}
.job__when {
  font-family: var(--font-mono);
  font-size: 12.5px;
  color: var(--fg-2);
  letter-spacing: 0.02em;
  white-space: nowrap;
}
.job__chev {
  width: 32px;
  height: 32px;
  border-radius: var(--radius-pill);
  border: 1px solid var(--border-2);
  display: grid;
  place-items: center;
  color: var(--fg-2);
  transition: transform var(--dur-base) var(--ease-out);
}
.job__chev.open {
  transform: rotate(180deg);
}

.job__detail {
  padding: 0 28px 28px 28px;
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.job__bullets {
  margin: 4px 0 0;
  padding: 4px 0 0;
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 10px;
  border-top: 1px solid var(--border-1);
}
.job__bullet {
  font-size: 14.5px;
  color: var(--fg-2);
  display: flex;
  gap: 12px;
  line-height: 1.6;
  padding-top: 10px;
}
.job__dash {
  color: var(--brand);
  font-family: var(--font-mono);
  margin-top: 1px;
  flex-shrink: 0;
}
.job__stack {
  display: flex;
  gap: 6px;
  flex-wrap: wrap;
  padding-top: 10px;
}

@media (max-width: 720px) {
  .job__when { display: none; }
}
</style>
