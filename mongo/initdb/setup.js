rs.initiate({"_id":"rs0","version":1,"members":[{"_id":0,"host":"mongodb:27017"}]},{force:true});

sleep(3000);
db.wooyun_drops.createIndex({"datetime":1});
db.wooyun_list.createIndex({"datetime":1});

print("Mongodb init completed!");