
# ユーザー作成
user1 = User.create({user_name:"USER1"})
user2 = User.create({user_name:"USER2"})
user3 = User.create({user_name:"USER3"})

#グループ作成
group1 = Group.create({group_name:"GROUP1"})
group2 = Group.create({group_name:"GROUP2"})
group3 = Group.create({group_name:"GROUP3"})

#関連付けを追加
user1.groups << group1
user1.groups << group2
user1.save

user2.groups << group2
user2.groups << group3
user2.save

user3.groups << group3
user3.groups << group1
user3.save