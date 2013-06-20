# First Ajax Project

This project is a simple secret sharing project. I've written two
models: `User` and `Secret`. I've also built `UsersController` and
`SessionsController` to do login for you.

## Phase I: `form_for` secrets

Write a `/users/123/secrets/new` form. Use `form_for`. You'll need to
create a nested route.

## Phase II: Add friendships (remote `button_to`)

Write a `Friendship` model to join `User` to `User`. Friendship is
one-way in this application. Write a simple `Friendships` controller
(the only action needed is `create`, I think). Nest a `friendship`
resource inside the `users` resource. Friending someone should be as
simple as POSTing to `/users/123/friendship`.

On the `/users` page, list all users, and add a `friend` button for
each. Make this button remote. When clicked, change the button text to
"Friending..." (use `ajax:before`), and disable. On `ajax:success`,
change text to "Friended".

When the template is first rendered, appropriately grey-out the button
if the user has already been friended.

## Phase III: Remove friendships

All things must end; you grow apart. You're still proud of your
friend, but you don't stay in touch anymore.

Add a second button, to unfriend a user. You'll need a `destroy`
action on `FriendshipsController`.

You now want to the unfriend button to appear when you are friends,
and the friend button to appear when you are not. The cleanest way to
do this is to:

0. Writeboth buttons, display them both.
0. Place the two buttons in a div or span, give this a CSS
   class of `friend_buttons`. Likewise, give your buttons classes of
   `friend` and `unfriend`.
0. If we are friends, set a second class on your div:
   `friended`. Otherwise, set `unfriended`
0. Write a CSS rule so that `.friend_buttons.friended friend` is
   `visible: false`. Do likewise for `.friend_buttons.unfriended
   unfriend`.
0. Lastly, your `ajax:success` method needs only to swap a class (see
   `$.toggleClass`).

## Phase IV: Remote secrets form

We have a `/users/123/secrets/new` page that displays a form. I'd like
to be able to post a new secret directly from the `/users/123` page.

Move the `new.html.erb` template into a partial. Make the form
remote. Render the partial in `users/show.html.erb` page.

On successful submission, add the new secret to the `ul` listing all
the secrets. Clear the form so the user can submit again :-)

## Phase V: Simple dynamic form (no nesting)

Let's allow users to tag secrets when they create them. Add `Tag` and
`SecretTagging` models. Set up appropriate associations.

Because `Secret` `has_many :tags, :through => :secret_taggings`, we
can use `Secret#tag_ids=`. We saw how to tag a secret with many tags
through a set of checkboxes. But what if there are lots of tags to
choose from? Do we really want to present 100 checkboxes?

Instead, let's present a single `select` tag. Let's also present a
link "Add another tag". Clicking this link should invoke a JS function
that will add another `select` tag.

A few hints.

### JSON data script trick

Creating new `select` tags means you'll have to create `option` tags:
one for each `Tag`. To give your JavaScript code access to the list of
`Tag`s, I'd store the JSONified `Tag`s in an HTML script tag:

```html+erb
<script type="application/json" id="tags_json" >
<%= Tag.all.to_json %>
</script>
```

You can then use these client-side via:

```javascript
var tag_objects = JSON.parse($("#tags_json").html());
```

### Underscore template trick

I'd use an underscore template

```html+erb
<script type="text/template">
<% unique_num = (new Date).getTime() %>
<% input_id = "secret_tag_ids_" + unique_num %>
<% name = "secret[tag_ids][]" %>

<label for="<%= input_id %>">Tag</label>
<select name="<%= name %>" id="<%= input_id %>">

</select>

</script>
```

* nested form
