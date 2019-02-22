# Object Associations

### User:
- Has many Resources
- Has many Hardwares
- Has one Setup
- Has  many Hardware through setup
- Has many Hardware_setups

### Resource: 
- Belongs to user
- Hardware
- Belongs to user
- Belongs to setup
- Setup
- Belongs to user
- Has many hardwares
- Hardware_setups
- Belongs to hardware
- Belongs to setup

### Models
- User (Fields: UserName, Email, Password, PasswordDigest)
- Resource (Fields: Name, link, icon, User_id, rank)
- Hardware (Fields: Name, images, link, rank)
- Setup (Fields: Name, images, specs, rank)
- Hardware_setups (Fields: Setup_id, Hardware_id
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
