# Capstone Project: Booksy


![enter image description here](https://media.giphy.com/media/vKwVYThtQocWA/giphy.gif)

My final project at GA is the lovechild of a Trello board and Goodreads. It's a book tracking app where users can add books they want to read, are reading, and have read. After a book has been completed, users can also add a rating. 

### Links
[Backend Repo (this one)](https://github.com/r-shahid/booksy-api)

[Frontend Repo](https://github.com/r-shahid/booksy-client)

[Deployed Backend](https://rs-booksy.herokuapp.com/)

[Deployed Frontend](https://rs-booksy.netlify.app/)

## Wireframes
![Mobile](https://res.cloudinary.com/rshahid/image/upload/v1605764234/capstone/5ffd3f1e16dd42cb9deb622d38d8f907_u6g9mb.png)

> I ended up not doing the dropdown lists because it'll look more Trello-ish if users can see the books move from one list to another

![Desktop](https://res.cloudinary.com/rshahid/image/upload/v1605764232/capstone/Da34d493ce98e6e673117de3033a76980_edzcbs.png)



## Schedule

|Day| Date| Deliverables  | Status |
|--|--|--|--|
| 1 | 11/19 | Project Approval |[X]|
|2|11/20|MVP|[X]|
|3|11/23|MVP|[X]|
|4|11/24|postMVP/Styling|[X]|
|5|11/30| Presentations| [_] |


## MVPs

|Component| Priority  | Estimated Time | Actual Time|
|--|--|--|--|
|Set up backend files  | H | 1hr| 1hr|
|Set up frontend|H|1hr|.5hr|
|User Auth|H|5hrs|4hrs|
|Home Page w/auth|H| 5hrs|2hrs
|Book Lists| H|4hrs|2.5hrs
|New Book Form| H| 2hrs|.5hrs
|Header/Footer|M|2hrs|1.5hrs
|Add Rating|L|2hrs|2.5hrs
|Render backend data on frontend|H|2hr| 10hrs
|Learn how to use Materialize| H| 5hrs| 1hr
|Styling|M|5hrs|8hrs
|Responsiveness|M|2hrs|1
|Deployment| H|1hrs|1.5hrs
|**Total**||37 hrs| 36hrs


## postMVP

|Component| Estimated Time| Actual Time|
|--|--|--|
| find a book API | .5hr |
|Popular books component to show books from the API| 3hrs|
|Allow users to add books from the new component to their "to be read" list with just a click| 4 hrs|
|**Total**|7.5 hrs|



## React Components

 - [x] App
 - [x] Header
 - [x] Nav
 - [x] Main
 - [x] Home Page
 - [x] Login Form
 - [x] Signup Form
 - [x] Book Lists
 - [x] About
 - [x] Footer




## React Architecture

![](https://res.cloudinary.com/rshahid/image/upload/v1605764808/capstone/Untitled_drawing_s4rch7.png)

> A few changes: Main and Home also have state. Home renders Nav, Login Form, and Signup Form and Lists renders Header. There is also a new About page component rendered by Main, accessed through Header and Nav.

## Additional Libraries

 - Materialize

## Code Snippets

Here's how I set up my star ratings:

First, I used a switch to render the star icons (from Materialize). There are six cases in total; a default case for unrated books, which will return 5 grey-ed out stars, and cases for ratings 1-5 with the corresponding number of stars colored in.

```javascript
const rating = () => {
    switch (book.rating) {
        case 1:
            return (
                <>
                    <button onClick={() => rateOne(book)} class='material-icons clicked one-star'>
                        star
                    </button>
                    <button
                        onClick={() => rateTwo(book)} class='material-icons two-stars'>
                        star
                    </button>
                    <button
                        onClick={() => rateThree(book)} class='material-icons three-stars'>
                        star
                    </button>
                    <button
                        onClick={() => rateFour(book)} class='material-icons four-stars'>
                        star
                    </button>
                    <button
                        onClick={() => rateFive(book)} class='material-icons five-stars'>
                        star
                    </button>
                </>
            );
        case 2:
            (and so on, for 2-5 stars and then default for unrated books)
```
Depending on which star is clicked, an onClick function is triggered to update the rating on the backend, and re-renders the books on the page. Once a re-render is triggered, the switch statement will shade in as many stars as appropriate.

```javascript
const rateFive = (book) => {
		axios({
			url: `https://rs-booksy.herokuapp.com/books/${book.id}`,
			method: 'PUT',
			headers: {
				Authorization: `Bearer ${token}`,
			},
			data: { rating: 5 },
		});
        setClick(!click);
    };
```

Stars are filled in by adding a class to stars as needed

```javascript
.clicked {
  color: var(--pink);
}
```

## Issues & Resolutions

I initially wrapped my Login and Sign-up form submit buttons in `<Link>` tags so that users could be taken to the next page after logging in. This caused a lot of errors because it took longer to get data from backend than it did to go to the next page. So, users would end up on the book lists page with no book data or a token to properly log in. 

==Resolution== A ternary operator that redirects to the book lists component only when book data has been received.

```javascript
{books[0] ? <Redirect to='/lists' /> : console.log('not redirecting')}
```

<hr>

New users would stay stuck on the home page since they don't have any book data and can't trigger the redirect.

==Resolution== When a new user makes an account, a sample book is added for them. 

<hr>

Book lists did not update immediately after onClick events.

==Resolution== I added a click state that is toggled true/false after every onClick event. Click is a dependency of the useEffect that gets book data, so the data is re-rendered and updated every time a book is added, moved, rated, or deleted.