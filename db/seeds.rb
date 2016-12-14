# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# ruby encoding: utf-8
# User
User.create!(username: 'test_admin',
             password: '12345678',      # to pass validation check
             password_digest: User.digest('1q2w3e4r..123'),
             is_admin: true)
User.create!(username: 'test_user',
             password: '12345678',      # to pass validation check
             password_digest: User.digest('1q2w3e4r..123'),
             is_admin: false)
# 吃
Waste.create(name: '餐盒+橡皮筋', description: '.',
             category: 'eat', image_name: 'canhe.png', weight: '1')
Waste.create(name: '餐碗+蓋', description: '.',
             category: 'eat', image_name: 'canwan.png', weight: '1')
Waste.create(name: '免洗筷', description: '.',
             category: 'eat', image_name: 'mianxikuai.png', weight: '1')
Waste.create(name: '免洗餐具', description: '.',
             category: 'eat', image_name: 'mianxicanju.png', weight: '1')
# 喝
Waste.create(name: '咖啡杯', description: '.',
             category: 'drink', image_name: 'kafeibei.png', weight: '1')
Waste.create(name: '飲料杯', description: '.',
             category: 'drink', image_name: 'yinliaobei.png', weight: '1')
Waste.create(name: '寶特瓶', description: '.',
             category: 'drink', image_name: 'baoteping.png', weight: '1')
Waste.create(name: '鋁罐', description: '.',
             category: 'drink', image_name: 'lvguan.png', weight: '1')
Waste.create(name: '鋁箔包', description: '.',
             category: 'drink', image_name: 'lvbobao.png', weight: '1')
Waste.create(name: '玻璃瓶', description: '.',
             category: 'drink', image_name: 'boliping.png', weight: '1')
Waste.create(name: '吸管', description: '.',
             category: 'drink', image_name: 'xiguan.png', weight: '1')
# 包裝垃圾
Waste.create(name: '小塑膠袋（食品包裝）', description: '.',
             category: 'wrapping', image_name: 'xiaosujiaodai.png',
             weight: '1')
Waste.create(name: '中塑膠袋（便當、飲料）', description: '.',
             category: 'wrapping', image_name: 'zhongsujiaodai.png',
             weight: '1')
Waste.create(name: '中食品包裝（內里結構）', description: '.',
             category: 'wrapping', image_name: 'zhongshipin.png', weight: '1')
Waste.create(name: '大塑膠袋（購物袋）', description: '.',
             category: 'wrapping', image_name: 'dasujiaodai.png', weight: '1')
# 紙張
Waste.create(name: '大', description: '.',
             category: 'paper', image_name: 'da.png', weight: '1')
Waste.create(name: '小', description: '.',
             category: 'paper', image_name: 'xiao.png', weight: '1')
# 補充垃圾
Waste.create(name: '菜單', description: '.',
             category: 'other', image_name: 'caidan.png', weight: '1')
Waste.create(name: '衛生紙', description: '.',
             category: 'other', image_name: 'weishengzhi.png', weight: '1')
Waste.create(name: '生活用品垃圾（洗衣精、牙膏、寵物飼料）', description: '.',
             category: 'other', image_name: 'shenghuoyongpin.png', weight: '1')
