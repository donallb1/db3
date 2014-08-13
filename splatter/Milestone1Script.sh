#!/bin/sh
#Create 3 Users

curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/users -d '{"user": {"email":"jonesad1@student.op.ac.nz", "name":"Alex jones", "password":"mynameisalex"}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/users -d '{"user": {"email":"donallb1@student.op.ac.nz", "name":"Liam Donald", "password":"mynameisliam"}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/users -d '{"user": {"email":"griffar2@student.op.ac.nz", "name":"Andrew Griffin", "password":"mynameisandrew"}}'

#Create 5 splatts for each user

curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Third Splatt", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Fourth Splatt", "user_id":3}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Second Splatt", "user_id":3}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Fifth Splatt", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Fourth Splatt", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Second Splatt", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"First Splatt", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Third Splatt", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"First Splatt", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Fifth Splatt", "user_id":3}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"First Splatt", "user_id":3}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Second Splatt", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Fifth Splatt", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Fourth Splatt", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Third Splatt", "user_id":3}}'


#Causes the first user to follow the other 2

curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/users/follows -d '{"id":1, "follows_id":2}'
curl -i -H "Content-type: application/json" -X POST http://donald.sqrawler.com:3000/users/follows -d '{"id":1, "follows_id":3}'

#Gets the first user’s splatts

curl -i -H "Content-type: application/json" -X GET http://donald.sqrawler.com:3000/users/splatts/1

#Gets the users followed by the first user

curl -i -H "Content-type: application/json" -X GET http://donald.sqrawler.com:3000/users/followers/1

#gets the first user’s news feed

curl -i -H "Content-type: application/json" -X GET http://donald.sqrawler.com:3000/users/splatts-feed/1

#causes the first users to unfollow the third user

curl -i -H "Content-type: application/json" -X DELETE http://donald.sqrawler.com:3000/users/follows/1/3

#displays the first user’s news feed after unfollowing the third

curl -i -H "Content-type: application/json" -X GET http://donald.sqrawler.com:3000/users/splatts-feed/1