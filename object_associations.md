# Object Associations

### User:
- Has many Resources
- Has many Hardwares
- Has one Setup
- Has many Hardwares

### Resource:
- Belongs to user

### Hardware
- Belongs to "hardwareable" (polymorphic association)

### Setup
- Belongs to user
- Has many hardwares

### Models
- User (Fields: UserName, Email, Password, PasswordDigest)
- Resource (Fields: Name, link, icon, rank, user_id)
- Hardware (Fields: Name, images, buy_link, rank, hardwareable references)
- Setup (Fields: Name, images, specs, rank, user_id)

## Views
### User
- Signup
- Login
- Index (all posts page)
- New (add item to nerdbox)
- show(profile)delete
- edit
### Resource
- index
- New
- Show/delete
- Edit
### Hardware
- index
- New
- Show/delete
- Edit
### Setup
- Index
- New
- Show/delete
- Edit
