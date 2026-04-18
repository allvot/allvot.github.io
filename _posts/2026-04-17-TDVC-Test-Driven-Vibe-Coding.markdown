---
layout: post
title:  "TDVC Test Driven Vibe Coding"
date:   2026-04-17 15:36:29 +0000
categories: ai code software engineering vibe coding ruby tdd bdd
toc: true
description: "Why Vibe Coding gets a bad rap, and how pairing it with TDD turns hallucination-prone AI output into verifiable, production-grade code."
image: /assets/img/VDD-w-claude.png
---

In today's day and age, **Vibe Coding** is sometimes *frowned upon*, and with good reason, after large software companies had [massive layoffs](https://www.wsj.com/business/has-the-era-of-the-mega-layoff-arrived-928f061d) and later had to *quietly* [start to re-hire](https://www.washingtontimes.com/news/2026/mar/10/ai-layoff-reversal-companies-rehire-customer-roles-eliminated/) for the positions they laid off.

But why are they re-hiring? Isn't AI the *"end all be all"* of software development? **Well, not quite.** AI has a lot of limitations when working on a particular project; you **cannot** just plug ChatGPT into your codebase and have it manage your code without any human input at all! And you shouldn't expect this to happen any time soon (*if ever*). You'll always need a pair of *Human Eyes* looking at your code, making sure the AI doesn't hallucinate. Maybe in the future you'll be able to delegate all coding to AI, **but not today**.

## <i class="fas fa-user-gear fa-fw me-2 text-muted"></i>The engineer behind the AI

Today, the **best use of your time** is to have an *engineer* behind an AI making sure that every line of code is **100% clean**, that it *meets the business/technical requirements*, and that it **doesn't jeopardize your business**.

So *how do you do it?* As an engineer, how do I make sure my AI is **hallucinating as little as possible** and is delivering **high-quality code**?

> Well, one of the ways I've used to great success is by **forcing my AI to always follow TDD**.
{: .prompt-tip }

## <i class="fas fa-flask-vial fa-fw me-2 text-muted"></i>A quick primer on TDD and BDD

If you don't know what TDD or BDD is, I'll give you a quick run down. **TDD** stands for *"Test-Driven Development"* and **BDD** stands for *"Behavior-Driven Development"*. Both follow the same principles, but BDD is a bit more advanced.

### <i class="fas fa-arrows-rotate fa-fw me-2 text-muted"></i>Red-Green-Refactor

The core of **TDD** is the **Red-Green-Refactor** cycle:

<div class="row g-3">
  {% include card.html icon="fas fa-circle-xmark" icon_color="text-danger"  title="Red"      content="Write a test that describes the behavior you want, and watch it *fail*. If it doesn't fail, the test isn't actually testing anything." %}
  {% include card.html icon="fas fa-circle-check" icon_color="text-success" title="Green"    content="Write the *minimum* amount of production code needed to make the test pass. No gold-plating, no extra features." %}
  {% include card.html icon="fas fa-broom"                                  title="Refactor" content="Now that the test is green, clean up the code without breaking the test. Rename things, extract methods, remove duplication." %}
</div>

Then you repeat. Every new piece of behavior starts with a *failing test*, and every change is guarded by the suite you've already written.

Let's walk through building a small `ShoppingCart` one behavior at a time:

1. A new cart has a total of `0`.
2. `#add_item` increases the total by the item's price.
3. `#apply_discount` reduces the total by a given percentage.

#### Cycle 1: a new cart is empty *(~3 min)*

**🔴 Red.** Write the failing test first:

```ruby
require 'shopping_cart'

RSpec.describe ShoppingCart do
  describe '#total' do
    it 'is zero for a new cart' do
      expect(ShoppingCart.new.total).to eq(0)
    end
  end
end
```
{: file="spec/shopping_cart_spec.rb" }

Run the suite in your terminal:

```console
$ bundle exec rspec
F

Failures:

  1) ShoppingCart#total is zero for a new cart
     Failure/Error: require 'shopping_cart'
     LoadError: cannot load such file -- shopping_cart

1 example, 1 failure
```

**🟢 Green.** The minimum code to make it pass:

```ruby
class ShoppingCart
  def total
    0
  end
end
```
{: file="lib/shopping_cart.rb" }

```console
$ bundle exec rspec
.

1 example, 0 failures
```

**🔵 Refactor.** Nothing to clean up yet. Move on.

#### Cycle 2: adding an item updates the total *(~5 min)*

**🔴 Red**:

```ruby
describe '#add_item' do
  it 'increases the total by the item price' do
    cart = ShoppingCart.new
    cart.add_item(price: 10)
    cart.add_item(price: 5)
    expect(cart.total).to eq(15)
  end
end
```
{: file="spec/shopping_cart_spec.rb" }

```console
$ bundle exec rspec
.F

Failures:

  1) ShoppingCart#add_item increases the total by the item price
     NoMethodError: undefined method `add_item' for an instance of ShoppingCart

2 examples, 1 failure
```

**🟢 Green**:

```ruby
class ShoppingCart
  def initialize
    @items = []
  end

  def add_item(price:)
    @items << price
  end

  def total
    @items.sum
  end
end
```
{: file="lib/shopping_cart.rb" }

```console
$ bundle exec rspec
..

2 examples, 0 failures
```

**🔵 Refactor.** Names are clear, no duplication. Skip.

#### Cycle 3: applying a percentage discount *(~7 min)*

**🔴 Red**:

```ruby
describe '#apply_discount' do
  it 'reduces the total by the given percentage' do
    cart = ShoppingCart.new
    cart.add_item(price: 100)
    cart.apply_discount(percent: 20)
    expect(cart.total).to eq(80)
  end
end
```
{: file="spec/shopping_cart_spec.rb" }

**🟢 Green**:

```ruby
class ShoppingCart
  def initialize
    @items = []
    @discount_percent = 0
  end

  def add_item(price:)
    @items << price
  end

  def apply_discount(percent:)
    @discount_percent = percent
  end

  def total
    subtotal = @items.sum
    subtotal - (subtotal * @discount_percent / 100)
  end
end
```
{: file="lib/shopping_cart.rb" }

**🔵 Refactor.** The `#total` math is doing too much. Extract private helpers so the intent reads top-to-bottom:

```ruby
class ShoppingCart
  def initialize
    @items = []
    @discount_percent = 0
  end

  def add_item(price:)
    @items << price
  end

  def apply_discount(percent:)
    @discount_percent = percent
  end

  def total
    subtotal - discount_amount
  end

  private

  def subtotal
    @items.sum
  end

  def discount_amount
    subtotal * @discount_percent / 100
  end
end
```
{: file="lib/shopping_cart.rb" }

Re-run the suite. Everything is still green, so the refactor is safe:

```console
$ bundle exec rspec
...

3 examples, 0 failures
```

Three tiny behaviors, three cycles, **about 15 minutes of focused work** for a human who already knows Ruby and RSpec. That's the honest cost of the discipline. You pay upfront to get a suite that locks the behavior in place, so the next change you make (or the next engineer who touches this class) can't silently break what already works.

### <i class="fas fa-list-check fa-fw me-2 text-muted"></i>Given-When-Then

**BDD** takes this a step further by framing tests around *behavior* instead of implementation. Rather than asking *"does this function return the right value?"*, you ask *"what should the system do in this scenario?"*. Tests are written in a human-readable **Given-When-Then** format:

<div class="row g-3">
  {% include card.html icon="fas fa-map-pin"   title="Given" content="some initial context." %}
  {% include card.html icon="fas fa-bolt"      title="When"  content="an action happens." %}
  {% include card.html icon="fas fa-bullseye"  title="Then"  content="we expect a specific outcome." %}
</div>

Our `#apply_discount` test from above already works, but framed in BDD style it starts reading like English, and it grows naturally as we pile on edge cases. Here's what three scenarios look like side by side:

```ruby
RSpec.describe ShoppingCart do
  describe '#apply_discount' do
    let(:cart) { ShoppingCart.new }

    context 'when given a 20% discount on a $100 item' do
      # Given
      before { cart.add_item(price: 100) }

      it 'reduces the total to $80' do
        # When
        cart.apply_discount(percent: 20)
        # Then
        expect(cart.total).to eq(80)
      end
    end

    context 'when the discount is 0%' do
      before { cart.add_item(price: 50) }

      it 'leaves the total unchanged' do
        cart.apply_discount(percent: 0)
        expect(cart.total).to eq(50)
      end
    end

    context 'when no items have been added' do
      it 'leaves the total at zero' do
        cart.apply_discount(percent: 30)
        expect(cart.total).to eq(0)
      end
    end
  end
end
```
{: file="spec/shopping_cart_spec.rb" }

Run the suite with `--format documentation` and the output *is* the spec. You can hand it straight to a product manager without translating anything:

```console
$ bundle exec rspec --format documentation

ShoppingCart
  #apply_discount
    when given a 20% discount on a $100 item
      reduces the total to $80
    when the discount is 0%
      leaves the total unchanged
    when no items have been added
      leaves the total at zero

3 examples, 0 failures
```

Writing these three scenarios by hand takes about 10 minutes once you're comfortable with RSpec and have the production code in place. The payoff is that the output above reads like a requirements document, which means anyone on the team can sanity-check the behavior without reading Ruby.

## <i class="fas fa-dumbbell fa-fw me-2 text-muted"></i>The catch is discipline

This makes the tests readable by *non-engineers* (product managers, designers, stakeholders), which keeps everyone aligned on what the software is actually supposed to do. Or that's the idea. In my experience, managers, designers, and stakeholders almost never check the tests or the behaviours they're supposed to describe, which is why being disciplined with this practice is super important. And we all know what discipline means: repeating the same cycle over and over. Write tests, run them, fix them, repeat, repeat... repeat.

This cycle has made some systems ultra-reliable, but some developers super tired and very grumpy.

> *"What do you mean I need to write my tests before I write the code? How would I even know what to test if there's nothing to test?"*
>
> *said the angry developer to his manager.*

## <i class="fas fa-wand-magic-sparkles fa-fw me-2 text-muted"></i>Test Driven Vibe Coding

With the advent of AI, you don't need to write every test and handle it yourself every time. When you create a workflow where you take advantage of AI to write your tests, you're making sure it's able to write tests that matter, and code that really delivers. Once you hand an AI a failing test, you're giving it a piece of *concrete, verifiable evidence* of whether the code currently works and whether the requirements are met, all before a single line of production code is written. The AI can't just hallucinate a plausible-looking solution and call it a day. It has to make the test pass. And once the test is green, you have *proof* that the code does what it's supposed to do. No more guessing. No more blind trust.

> Just **vibes, backed by tests**.
{: .prompt-tip }

### <i class="fas fa-bolt fa-fw me-2 text-muted"></i>The same feature, with TDVC

Now hand the *same* requirements to the `tdd-orchestrator` agent with one prompt:

```text
Build a ShoppingCart class using strict TDD. Three behaviors, one Red-Green-Refactor
cycle each, in this order:

  1. A new cart has a total of 0.
  2. #add_item(price:) increases the total by the item's price.
  3. #apply_discount(percent:) reduces the total by the given percentage.

Constraints:
  - Ruby + RSpec, following BetterSpecs conventions.
  - Delegate each cycle to tdd-backend-engineer. Do NOT write production code
    yourself.
  - For every cycle, run `bundle exec rspec` and show me the console output after
    RED and after GREEN.
  - Refactor only when there's duplication or unclear naming worth fixing.
  - Stop and ask before adding any behavior I didn't list.
```

Here's what actually happens when you run that:

1. `tdd-orchestrator` translates the three behaviors into Given-When-Then scenarios and lays out the task queue.
2. For each scenario it dispatches a test-first task to `tdd-backend-engineer`, which writes the failing spec, runs `rspec`, confirms the expected failure, writes the minimum implementation, re-runs `rspec`, and reports back.
3. After cycle 3, the orchestrator spots the duplicated math in `#total` and dispatches a refactor task. One last `rspec` run confirms all three examples are still green.

> **Total wall-clock time:** ~2 minutes of agent runtime, plus ~30 seconds of you reviewing the diff and the `rspec` output. Same suite, same production code, same discipline, just without the typing.
{: .prompt-tip }

Yes, the AI is faster, but that's not really the win here. What actually matters is that every line of production code in the final commit is backed by a failing test *the AI couldn't peek at while writing*. That's the verifiable evidence TDVC is built on.

### <i class="fas fa-list-check fa-fw me-2 text-muted"></i>Layering BDD edge cases with TDVC

Once the happy path is in place, the same orchestrator can pile on edge-case scenarios in a clean BDD style. Different prompt, same agent:

```text
Add BDD-style edge-case scenarios for ShoppingCart#apply_discount to
spec/shopping_cart_spec.rb. Cover:

  1. when given a 20% discount on a $100 item, total becomes 80
  2. when the discount is 0%, total stays unchanged
  3. when no items have been added, total stays at 0

Constraints:
  - Follow BetterSpecs: each context starts with "when", "with", or "without".
  - Use `let` and `before` for setup. No instance variables.
  - Keep each `it` description under 40 characters.
  - Delegate to tdd-backend-engineer.
  - After all three scenarios are in place, run
    `bundle exec rspec --format documentation` and paste the output so I can
    read the suite like prose.
```

The agent writes each scenario test-first, watches it fail for the right reason, and only extends production code when a scenario forces it. About a minute of runtime later, the `--format documentation` output reads like a spec document you can share with a PM.

## <i class="fas fa-people-group fa-fw me-2 text-muted"></i>My Claude Code agent setup

> This setup is built for **[Claude Code](https://docs.claude.com/en/docs/claude-code/overview)**. Though similar setups can be achieved for other tools I want to focus on this one.
{: .prompt-info }

I drive TDVC day-to-day with three agents. One plans and delegates; the other two are focused specialists. Each lives as a single markdown file under `~/.claude/agents/`.

<div class="row g-3">
  {% include card.html icon="fas fa-sitemap" tag="opus"   title="tdd-orchestrator"     content="The technical lead. Takes an ambiguous request, writes BDD scenarios in Given-When-Then, designs the component breakdown, then dispatches atomic, test-first sub-tasks to the specialists below. It's the only agent I usually talk to directly." %}
  {% include card.html icon="fas fa-server"  tag="sonnet" title="tdd-backend-engineer" content="Backend TDD enforcer. Writes request and model specs using [BetterSpecs](https://betterspecs.org/) conventions: RSpec, FactoryBot, `let`/`let!`, `is_expected.to`, `context \"when...\"`. Refuses to write production code before a failing test exists." %}
  {% include card.html icon="fab fa-vuejs"   tag="sonnet" title="vue-tdd-engineer"     content="Frontend TDD for Vue 3. Composition API with `<script setup>`, Vitest, and Vue Test Utils. Queries by role and label rather than class names, so tests describe user behavior instead of implementation details." %}
</div>

### <i class="fas fa-terminal fa-fw me-2 text-muted"></i>How to set this up yourself

1. **Install Claude Code.** Run `npm install -g @anthropic-ai/claude-code`, then `claude` inside any project directory.
2. **Open the agent manager with `/agents`.** Inside a Claude Code session, just type `/agents`. It opens an interactive UI for creating, editing, listing, and deleting subagents, so no manual file wrangling required.

    ```text
    > /agents

    ❯ Create new agent
      Edit existing agent
      Delete agent
    ```

3. **Walk through the create flow.** Pick *Create new agent* and Claude Code prompts you for each field in order:
    - **Scope**: *Personal* (saves to `~/.claude/agents/`, available in every project) or *Project* (saves to `.claude/agents/`, versioned with the repo).
    - **Name**: e.g. `tdd-backend-engineer`.
    - **Description**: one precise sentence explaining *when* this agent should fire. Claude Code uses it to route tasks.
    - **System prompt**: the body that defines the agent's persona. You can write it by hand or ask Claude Code to *generate a first draft* from the description, then edit it down.
    - **Model**: `opus` for planners and architects, `sonnet` for the focused TDD specialists, `haiku` for cheap mechanical work, or `inherit` to use the parent session's model.
    - **Tools**: optionally restrict access (e.g. a review agent with no `Edit` or `Bash`, read-only by design).

4. **Save.** Claude Code writes the markdown file for you with the correct frontmatter and system prompt. You can still open it directly at `~/.claude/agents/<name>.md` to tweak anything the UI doesn't expose (like the `color` field or `<example>` blocks).
5. **Let the orchestrator delegate.** Once `tdd-orchestrator` is installed, I can say *"Build me a login endpoint with JWT refresh tokens"* and it writes the BDD scenarios, hands the RED/GREEN/REFACTOR cycles for the API to `tdd-backend-engineer`, and the login form to `vue-tdd-engineer`.
6. **Iterate.** Re-run `/agents` → *Edit existing agent* to tune any prompt without leaving the session. Start strict (*"refuse to write implementation without a failing test first"*) and relax where it makes sense.

> The `description` field is what Claude Code uses to route tasks to the right agent, so write it precisely. Include `<example>` blocks in the system prompt showing the exact situations where the agent should fire. Claude Code matches on those to pick the right specialist automatically.
{: .prompt-tip }

### <i class="fas fa-clipboard fa-fw me-2 text-muted"></i>Copy-paste prompt samples

When you run `/agents` → *Create new agent* → *Generate with Claude*, Claude Code asks you to describe the agent in plain English and then writes the full system prompt for you. Paste any of the four prompts below as that description to get an agent equivalent to mine. Tweak the language, stack, and conventions before generating so Claude tailors it to your project.

#### tdd-orchestrator

```text
Create an agent that acts as a Senior Staff Engineer and Technical Orchestrator. It should break down complex software engineering tasks into small, well-scoped sub-tasks following strict TDD/BDD practices, and coordinate specialized sub-agents to execute them. It's the technical lead. It plans, delegates, and oversees execution, but usually doesn't write production code itself.

Non-negotiables:
- Tests ALWAYS precede implementation. Never allow GREEN before RED.
- Write BDD scenarios in Given-When-Then before decomposing the work technically.
- Think in Red-Green-Refactor cycles at all times.

Workflow:
1. Requirements analysis (functional, non-functional, constraints). Ask max 3–5 clarifying questions if critical info is missing.
2. Write BDD scenarios covering happy paths, edge cases, and error conditions.
3. Design component structure and interfaces between them.
4. Decompose into atomic tasks, sequenced into waves: Wave 1 (tests), Wave 2 (implementation), Wave 3 (refactor/integration).
5. Dispatch each task to the right specialist sub-agent (backend, frontend, devops) with complete self-contained context, explicit inputs, expected outputs, acceptance criteria, and the failing tests it must satisfy. Mark each task with its TDD phase: RED, GREEN, or REFACTOR.
6. Verify each phase gate before declaring work complete.

Add examples for: a new feature built from scratch, a refactor of a messy module, and a multi-component data pipeline.
```

#### tdd-backend-engineer

```text
Create an agent that acts as a senior backend developer and testing specialist with 12+ years of TDD/BDD experience. It should write, run, and fix backend tests, and drive feature implementation through the RED-GREEN-REFACTOR cycle. Treat the cycle as an inviolable law, not a guideline.

Rules:
- RED: Write a failing test first, run it, confirm it fails for the right reason.
- GREEN: Write the minimum production code to pass the test. No gold-plating.
- REFACTOR: Clean up test and production code while keeping everything green.
- If asked to implement a feature without a failing test, refuse and redirect to RED.

Test-writing standards:
- Use Given/When/Then structure in every test.
- One assertion concept per test. Test behavior, not implementation. Avoid testing private methods directly.
- Cover happy paths, edge cases, boundaries, and error paths.
- Mock external dependencies for unit tests; use integration tests for real component interactions.

If the project uses RSpec on Rails, follow BetterSpecs (betterspecs.org) conventions:
- Request specs live in spec/requests/; describe them as "GET /api/v1/users".
- `it` descriptions under 40 chars, third-person, never starting with "should".
- Always use `context` blocks starting with "when", "with", or "without".
- Use `expect` syntax; `is_expected.to` for one-liners.
- Use `let`/`let!`, never instance variables. Use FactoryBot (`build`, `build_stubbed`, `create_list`), never fixtures.
- Test HTTP status with `have_http_status`, side effects with `change` matchers.
- For model specs, use `#instance_method` / `.class_method` naming and test validations, associations, scopes, and callbacks.

Announce every phase transition (RED → GREEN → REFACTOR). Never trust a test that has never been red.

Add examples for: adding a new API endpoint, writing tests for an existing service class, and fixing a set of failing tests after a refactor.
```

#### vue-tdd-engineer

```text
Create an agent that acts as an elite Vue.js frontend engineer specialized in TDD. It should build Vue 3 components, fix bugs, and refactor existing code strictly through the red-green-refactor cycle. It must never write implementation code before a failing test exists.

Cycle:
- RED: Write the smallest failing test. Run it. Confirm it fails for the right reason. Announce "RED: failing because [reason]." Do not write implementation yet.
- GREEN: Write the minimum code to pass. Hardcoding is acceptable at this stage. Announce "GREEN: passing."
- REFACTOR: Improve naming, remove duplication, simplify. Run the full suite. Announce "REFACTOR: all tests still passing."

Vue 3 conventions:
- Composition API with `<script setup>` as the default.
- Single-responsibility components. Props down, emits up, both explicitly typed with `defineProps` and `defineEmits`.
- Use `computed` for derived state, `ref` for primitives, `reactive` for objects.
- Keep templates declarative. Move logic into `<script setup>`.
- Always `key` on `v-for`. Never combine `v-if` with `v-for` on the same element.
- Composables prefixed with `use`. Pinia for global state.

Testing:
- Vitest + Vue Test Utils. Use @testing-library/vue for user-centric interaction tests.
- Query by accessible role and label (`getByRole`, `getByLabelText`), NOT class names or IDs. Tests should describe user behavior, not implementation.
- Test rendering based on props, user interactions, emitted events, conditional rendering, and slots.
- Do NOT test Vue internals, private state, or styles unless they are critical to functionality.

Simplicity over cleverness. The simplest code that passes the tests wins.

Add examples for: building a new component from scratch, adding validation to an existing form, and reproducing a bug with a failing test before fixing it.
```

---

{% assign cv = site.data.cv %}
{% assign contact_email = cv.contact.email %}
{% assign contact_linkedin = cv.contact.linkedin %}
{% assign contact_github = cv.contact.github %}

> **Let's talk**
>
> Want to bring this kind of AI-plus-TDD workflow into your team? Get in touch.
>
> - <i class="fas fa-envelope fa-fw"></i> [{{ contact_email }}](mailto:{{ contact_email }})
> - <i class="fab fa-linkedin fa-fw"></i> [LinkedIn]({{ contact_linkedin }})
> - <i class="fab fa-github fa-fw"></i> [GitHub]({{ contact_github }})
{: .prompt-info }
