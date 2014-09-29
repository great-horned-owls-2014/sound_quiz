puts "loading rails ..."
# load rails app
require_relative 'config/environment'

# pretty print
require 'pp'

# gross hack
puts "resetting the db ..."
`rake db:drop && rake db:create && rake db:migrate && rake db:seed`

puts "running 'driver' code ..."

# same format as the params sent from the frontend
artist_and_track_data =
  {"name"=>"The Cat Empire",
   "id"=>"71333554",
   "list"=>
    {"0"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a1941.phobos.apple.com/us/r30/Music/81/10/b8/mzm.judqomaz.aac.p.m4a",
       "trackName"=>"Fishies"},
     "1"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a452.phobos.apple.com/us/r30/Music/7b/f9/30/mzm.eaxhfaht.aac.p.m4a",
       "trackName"=>"So Many Nights"},
     "2"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a1025.phobos.apple.com/us/r30/Music/81/97/f9/mzm.harullly.aac.p.m4a",
       "trackName"=>"Til the Ocean Takes Us All"},
     "3"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a893.phobos.apple.com/us/r30/Music/98/75/79/mzm.bkpxivua.aac.p.m4a",
       "trackName"=>"Strong Coffee"},
     "4"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a1474.phobos.apple.com/us/r30/Music/02/4b/8a/mzm.ubdqnmmm.aac.p.m4a",
       "trackName"=>"Sunny Moon"},
     "5"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a94.phobos.apple.com/us/r30/Music/7d/b0/0f/mzm.xlcahieo.aac.p.m4a",
       "trackName"=>"No Longer There"},
     "6"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a1250.phobos.apple.com/us/r30/Music/7f/fe/a1/mzm.yjedkqdj.aac.p.m4a",
       "trackName"=>"Panama"},
     "7"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a580.phobos.apple.com/us/r30/Music/70/f1/24/mzm.qfloqkzf.aac.p.m4a",
       "trackName"=>"Wanted to Write a Love Song"},
     "8"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a1716.phobos.apple.com/us/r30/Music/a4/36/97/mzm.pvrbyqky.aac.p.m4a",
       "trackName"=>"Lonely Moon"},
     "9"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a741.phobos.apple.com/us/r30/Music/20/68/3d/mzm.imyhfmqs.aac.p.m4a",
       "trackName"=>"So Long"},
     "10"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a875.phobos.apple.com/us/r30/Music/70/a9/1f/mzm.lzhioahr.aac.p.m4a",
       "trackName"=>"Won't Be Afraid"},
     "11"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a1594.phobos.apple.com/us/r30/Music/ee/ad/5e/mzm.vattkbwv.aac.p.m4a",
       "trackName"=>"Voodoo Cowboy"},
     "12"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a1642.phobos.apple.com/us/r30/Music/77/5c/67/mzm.cveokykw.aac.p.m4a",
       "trackName"=>"Radio Song"},
     "13"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a1881.phobos.apple.com/us/r30/Music/84/98/88/mzm.xufbmhnj.aac.p.m4a",
       "trackName"=>"The Darkness"},
     "14"=>
      {"artworkUrl100"=>
        "http://a5.mzstatic.com/us/r30/Music/a4/07/37/mzi.zayozfvx.100x100-75.jpg",
       "previewUrl"=>
        "http://a551.phobos.apple.com/us/r30/Music/14/b1/7a/mzm.evubgntn.aac.p.m4a",
       "trackName"=>"No Mountain"},
     "15"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/28/af/6f/28af6fe7-9b4f-47df-d354-7e43e1de6b6f/859708139310_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a145.phobos.apple.com/us/r30/Music/51/3a/2e/mzi.hibkmphs.aac.p.m4a",
       "trackName"=>"Two Shoes"},
     "16"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/7c/29/be/7c29becc-d4a0-ed32-67e5-57c15b4740d4/925633.100x100-75.jpg",
       "previewUrl"=>
        "http://a1481.phobos.apple.com/us/r30/Music/v4/d7/17/61/d71761b8-3951-eef7-e729-da3e1bff6b9b/mzaf_4502727745459971500.aac.m4a",
       "trackName"=>"Still Young"},
     "17"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1519.phobos.apple.com/us/r30/Music/81/91/f5/mzi.kdnrhzrx.aac.p.m4a",
       "trackName"=>"Hello"},
     "18"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/7c/29/be/7c29becc-d4a0-ed32-67e5-57c15b4740d4/925633.100x100-75.jpg",
       "previewUrl"=>
        "http://a1176.phobos.apple.com/us/r30/Music/v4/42/3b/62/423b62fc-d17c-38c8-f812-d00549f9be30/mzaf_9160537561461283611.aac.m4a",
       "trackName"=>"Steal the Light"},
     "19"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/f3/70/90/f3709075-8934-2542-9a68-7a8fdc5ebfb5/859708140132_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1576.phobos.apple.com/us/r30/Music/58/a1/5c/mzi.jdaolejx.aac.p.m4a",
       "trackName"=>"Falling"},
     "20"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/7c/29/be/7c29becc-d4a0-ed32-67e5-57c15b4740d4/925633.100x100-75.jpg",
       "previewUrl"=>
        "http://a1383.phobos.apple.com/us/r30/Music2/v4/26/26/45/262645a7-8c21-738f-9744-f9897007c83e/mzaf_4194368444720964457.aac.m4a",
       "trackName"=>"Brighter Than Gold"},
     "21"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/f3/70/90/f3709075-8934-2542-9a68-7a8fdc5ebfb5/859708140132_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a672.phobos.apple.com/us/r30/Music/12/cb/74/mzi.yjmpqsgf.aac.p.m4a",
       "trackName"=>"On My Way"},
     "22"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/7c/29/be/7c29becc-d4a0-ed32-67e5-57c15b4740d4/925633.100x100-75.jpg",
       "previewUrl"=>
        "http://a217.phobos.apple.com/us/r30/Music2/v4/49/ff/73/49ff7328-1a1c-626d-f810-ede8e58765e3/mzaf_4740244400639297620.aac.m4a",
       "trackName"=>"Prophets in the Sky"},
     "23"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a808.phobos.apple.com/us/r30/Music/05/50/3b/mzi.clzasxoq.aac.p.m4a",
       "trackName"=>"The Chariot"},
     "24"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/7c/29/be/7c29becc-d4a0-ed32-67e5-57c15b4740d4/925633.100x100-75.jpg",
       "previewUrl"=>
        "http://a1945.phobos.apple.com/us/r30/Music2/v4/98/39/88/983988a7-bf02-0a27-8d9c-6b4c74116225/mzaf_7180644677017781883.aac.m4a",
       "trackName"=>"All Night Loud"},
     "25"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/7c/29/be/7c29becc-d4a0-ed32-67e5-57c15b4740d4/925633.100x100-75.jpg",
       "previewUrl"=>
        "http://a1344.phobos.apple.com/us/r30/Music2/v4/7f/2f/9b/7f2f9bd1-e67e-9569-718b-07723a41bfd4/mzaf_5967932467914455227.aac.m4a",
       "trackName"=>"Like a Drum"},
     "26"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/c3/9d/92/c39d92b3-09d7-7032-fbea-9a22caf5f1f8/859709455037_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1987.phobos.apple.com/us/r30/Music/v4/70/81/f9/7081f9c9-5ec6-082b-2475-b79f4659630e/mzaf_5663417967539842998.aac.m4a",
       "trackName"=>"Brighter Than Gold"},
     "27"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/7c/29/be/7c29becc-d4a0-ed32-67e5-57c15b4740d4/925633.100x100-75.jpg",
       "previewUrl"=>
        "http://a1685.phobos.apple.com/us/r30/Music/v4/23/67/8e/23678eb8-0b0a-c09a-a97e-d85a95d7cfe3/mzaf_5170318863207187621.aac.m4a",
       "trackName"=>"Sleep Won't Sleep"},
     "28"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a655.phobos.apple.com/us/r30/Music/3d/81/c6/mzi.ssmgxiav.aac.p.m4a",
       "trackName"=>"The Lost Song"},
     "29"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/7c/29/be/7c29becc-d4a0-ed32-67e5-57c15b4740d4/925633.100x100-75.jpg",
       "previewUrl"=>
        "http://a1001.phobos.apple.com/us/r30/Music2/v4/b6/e8/5b/b6e85b9e-a13d-061a-e5a1-f400cec0525f/mzaf_4805799340890910682.aac.m4a",
       "trackName"=>"Wild Animals"},
     "30"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/7c/29/be/7c29becc-d4a0-ed32-67e5-57c15b4740d4/925633.100x100-75.jpg",
       "previewUrl"=>
        "http://a1092.phobos.apple.com/us/r30/Music/v4/3f/15/78/3f157847-8fa6-3a04-2d92-92cf80a62d35/mzaf_582176531220088474.aac.m4a",
       "trackName"=>"Go"},
     "31"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/7c/29/be/7c29becc-d4a0-ed32-67e5-57c15b4740d4/925633.100x100-75.jpg",
       "previewUrl"=>
        "http://a1187.phobos.apple.com/us/r30/Music/v4/d3/01/5f/d3015f73-5732-696b-12ff-d7c2282bb4cd/mzaf_4110159510075998069.aac.m4a",
       "trackName"=>"Am I Wrong"},
     "32"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/7c/29/be/7c29becc-d4a0-ed32-67e5-57c15b4740d4/925633.100x100-75.jpg",
       "previewUrl"=>
        "http://a1832.phobos.apple.com/us/r30/Music/v4/d1/6b/c0/d16bc06a-83cc-d6ad-ba6c-7a15906efc48/mzaf_5023559209739005625.aac.m4a",
       "trackName"=>"Open up Your Face"},
     "33"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/f3/70/90/f3709075-8934-2542-9a68-7a8fdc5ebfb5/859708140132_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1187.phobos.apple.com/us/r30/Music/76/87/53/mzi.exnjsufl.aac.p.m4a",
       "trackName"=>"Waiting"},
     "34"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/7c/29/be/7c29becc-d4a0-ed32-67e5-57c15b4740d4/925633.100x100-75.jpg",
       "previewUrl"=>
        "http://a147.phobos.apple.com/us/r30/Music/v4/37/dd/5e/37dd5e38-58ca-9034-91ce-645767acc66a/mzaf_8806863649692805797.aac.m4a",
       "trackName"=>"Don't Throw Your Hands Up"},
     "35"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/f3/70/90/f3709075-8934-2542-9a68-7a8fdc5ebfb5/859708140132_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1853.phobos.apple.com/us/r30/Music/c0/71/2e/mzi.ixbrfaba.aac.p.m4a",
       "trackName"=>"Call Me Home"},
     "36"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1857.phobos.apple.com/us/r30/Music/c9/c6/67/mzi.zollpsps.aac.p.m4a",
       "trackName"=>"The Wine Song"},
     "37"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/f3/70/90/f3709075-8934-2542-9a68-7a8fdc5ebfb5/859708140132_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a140.phobos.apple.com/us/r30/Music/a9/f8/39/mzi.atreppks.aac.p.m4a",
       "trackName"=>"Feeling's Gone"},
     "38"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/f3/70/90/f3709075-8934-2542-9a68-7a8fdc5ebfb5/859708140132_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a109.phobos.apple.com/us/r30/Music/06/a5/f3/mzi.dgirbjky.aac.p.m4a",
       "trackName"=>"All Hell"},
     "39"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/f3/70/90/f3709075-8934-2542-9a68-7a8fdc5ebfb5/859708140132_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a226.phobos.apple.com/us/r30/Music/ba/5a/44/mzi.mdwlclkq.aac.p.m4a",
       "trackName"=>"Shoulders"},
     "40"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/f3/70/90/f3709075-8934-2542-9a68-7a8fdc5ebfb5/859708140132_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1125.phobos.apple.com/us/r30/Music/c7/8f/2e/mzi.nazztfbq.aac.p.m4a",
       "trackName"=>"Reasonably Fine"},
     "41"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/f3/70/90/f3709075-8934-2542-9a68-7a8fdc5ebfb5/859708140132_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a761.phobos.apple.com/us/r30/Music/51/2c/9f/mzi.iftrvfam.aac.p.m4a",
       "trackName"=>"The Heart Is a Cannibal"},
     "42"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/f3/70/90/f3709075-8934-2542-9a68-7a8fdc5ebfb5/859708140132_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1126.phobos.apple.com/us/r30/Music/83/52/4f/mzi.qwesxdua.aac.p.m4a",
       "trackName"=>"Only Light"},
     "43"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/f3/70/90/f3709075-8934-2542-9a68-7a8fdc5ebfb5/859708140132_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a884.phobos.apple.com/us/r30/Music/82/39/11/mzi.wkmugxar.aac.p.m4a",
       "trackName"=>"Beyond All"},
     "44"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/28/af/6f/28af6fe7-9b4f-47df-d354-7e43e1de6b6f/859708139310_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a988.phobos.apple.com/us/r30/Music/00/c5/f4/mzi.hqjdxbuf.aac.p.m4a",
       "trackName"=>"Sly"},
     "45"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1543.phobos.apple.com/us/r30/Music/8c/5e/0f/mzi.kqqjhkmi.aac.p.m4a",
       "trackName"=>"Days Like These"},
     "46"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a932.phobos.apple.com/us/r30/Music/86/f9/9f/mzi.zuzpuvoo.aac.p.m4a",
       "trackName"=>"How to Explain"},
     "47"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a422.phobos.apple.com/us/r30/Music/32/8b/99/mzi.ibryvojb.aac.p.m4a",
       "trackName"=>"The Ryhthm"},
     "48"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1270.phobos.apple.com/us/r30/Music/00/31/ac/mzi.hojpzkug.aac.p.m4a",
       "trackName"=>"One Four Five"},
     "49"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a839.phobos.apple.com/us/r30/Music/fc/b0/c8/mzi.zqemvsyn.aac.p.m4a",
       "trackName"=>"All That Talking"},
     "50"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1303.phobos.apple.com/us/r30/Music/dc/a0/0b/mzi.ljhtilzl.aac.p.m4a",
       "trackName"=>"The Crowd"},
     "51"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/28/af/6f/28af6fe7-9b4f-47df-d354-7e43e1de6b6f/859708139310_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a771.phobos.apple.com/us/r30/Music/ac/8c/1d/mzi.nkromcna.aac.p.m4a",
       "trackName"=>"The Car Song"},
     "52"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a941.phobos.apple.com/us/r30/Music/ce/ce/2e/mzi.jkhjdftu.aac.p.m4a",
       "trackName"=>"Manifesto"},
     "53"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a701.phobos.apple.com/us/r30/Music/2f/69/45/mzi.ulwegmgq.aac.p.m4a",
       "trackName"=>"Nothing"},
     "54"=>
      {"artworkUrl100"=>
        "http://a4.mzstatic.com/us/r30/Music/v4/13/db/47/13db47f7-0561-5405-c18f-c6a4b78f397b/859708139075_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1221.phobos.apple.com/us/r30/Music/92/8a/4e/mzi.ysrtdecb.aac.p.m4a",
       "trackName"=>"Beanni"},
     "55"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a117.phobos.apple.com/us/r30/Music/16/3f/9e/mzi.iolpgpgm.aac.p.m4a",
       "trackName"=>"Hotel California (Live At Metropolis)"},
     "56"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1419.phobos.apple.com/us/r30/Music/c8/5a/a4/mzi.xoamhbbb.aac.p.m4a",
       "trackName"=>"The Rhythm (Live At the Bowery Ballroom)"},
     "57"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a768.phobos.apple.com/us/r30/Music/38/c7/d2/mzi.crdzchlg.aac.p.m4a",
       "trackName"=>"The Lost Song (Live At Metropolis)"},
     "58"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a601.phobos.apple.com/us/r30/Music/c4/1b/d7/mzi.lxybwsmn.aac.p.m4a",
       "trackName"=>"How to Explain? (Live At Sidney Myer Music Bowl)"},
     "59"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1758.phobos.apple.com/us/r30/Music/57/f6/8c/mzi.qkzxoevi.aac.p.m4a",
       "trackName"=>"Rhyme and Reason (Live At Metropolis)"},
     "60"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1995.phobos.apple.com/us/r30/Music/8b/41/66/mzi.knsjbsux.aac.p.m4a",
       "trackName"=>"Dumb Things (Live At Shepherds Bush Empire)"},
     "61"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1998.phobos.apple.com/us/r30/Music/cf/85/99/mzi.uupkdpvi.aac.p.m4a",
       "trackName"=>"Fishies (Live At the Metro Theatre)"},
     "62"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1303.phobos.apple.com/us/r30/Music/e5/1c/1a/mzi.prnsngid.aac.p.m4a",
       "trackName"=>"Sly (Live At the Metro Theatre)"},
     "63"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1142.phobos.apple.com/us/r30/Music/65/f9/9b/mzi.bblxyaub.aac.p.m4a",
       "trackName"=>"The Chariot (Live At the Metro Theatre)"},
     "64"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1651.phobos.apple.com/us/r30/Music/c0/97/f1/mzi.hhwvoazl.aac.p.m4a",
       "trackName"=>"Two Shoes (Live At Iwaki Auditorium)"},
     "65"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a572.phobos.apple.com/us/r30/Music/a0/00/0a/mzi.ddgkwtgh.aac.p.m4a",
       "trackName"=>"The Car Song (Live At Triple J's Awol Concert)"},
     "66"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a2000.phobos.apple.com/us/r30/Music/6c/6d/22/mzi.fgprgmok.aac.p.m4a",
       "trackName"=>"Hello (Live At Triple J's Awol Concert)"},
     "67"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a309.phobos.apple.com/us/r30/Music/f0/97/00/mzi.bfprtilh.aac.p.m4a",
       "trackName"=>"Days Like These (Live At Trabendo)"},
     "68"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1519.phobos.apple.com/us/r30/Music/17/19/27/mzi.ioppvyon.aac.p.m4a",
       "trackName"=>"All That Talking (Live At Iwaki Auditorium)"},
     "69"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a656.phobos.apple.com/us/r30/Music/7a/e0/89/mzi.abigwpzh.aac.p.m4a",
       "trackName"=>"The Darkness (Live At Sidney Myer Music Bowl)"},
     "70"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a931.phobos.apple.com/us/r30/Music/4d/99/7c/mzi.srdvnvuq.aac.p.m4a",
       "trackName"=>
        "Til the Ocean Takes Us All (Live At Triple J's Awol Concert)"},
     "71"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1893.phobos.apple.com/us/r30/Music/ef/ac/b2/mzi.lgteraud.aac.p.m4a",
       "trackName"=>"No Longer There (Live At Sidney Myer Music Bowl)"},
     "72"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a362.phobos.apple.com/us/r30/Music/e5/8e/a9/mzi.nnhiwivn.aac.p.m4a",
       "trackName"=>"Lonely Moon (Live At Iwaki Auditorium)"},
     "73"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a922.phobos.apple.com/us/r30/Music/8d/f1/3e/mzi.bhmbrxoq.aac.p.m4a",
       "trackName"=>"So Many Nights (Live At Woodford Folk Festival)"},
     "74"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a447.phobos.apple.com/us/r30/Music/af/33/df/mzi.bmnmpiqj.aac.p.m4a",
       "trackName"=>"Sunny Moon (Live At Sidney Myer Music Bowl)"},
     "75"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a301.phobos.apple.com/us/r30/Music/60/39/65/mzi.jsemicyd.aac.p.m4a",
       "trackName"=>"The Wine Song (Live At the Sidney Myer Music Bowl)"},
     "76"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/df/4b/bf/df4bbfef-9979-c52b-9a65-468b1205724d/859708977721_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a105.phobos.apple.com/us/r30/Music/55/4d/d1/mzi.eginchqa.aac.p.m4a",
       "trackName"=>"In My Pocket (Live At Woodford Folk Festival)"},
     "77"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/28/af/6f/28af6fe7-9b4f-47df-d354-7e43e1de6b6f/859708139310_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1955.phobos.apple.com/us/r30/Music/93/b5/79/mzi.ptbuyppd.aac.p.m4a",
       "trackName"=>"Protons, Neutrons, Electrons"},
     "78"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/28/af/6f/28af6fe7-9b4f-47df-d354-7e43e1de6b6f/859708139310_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a687.phobos.apple.com/us/r30/Music/92/09/5b/mzi.gxnywrwr.aac.p.m4a",
       "trackName"=>"Miserere"},
     "79"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/28/af/6f/28af6fe7-9b4f-47df-d354-7e43e1de6b6f/859708139310_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a883.phobos.apple.com/us/r30/Music/5f/05/73/mzi.upfnvzga.aac.p.m4a",
       "trackName"=>"Sol y Sombra"},
     "80"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/28/af/6f/28af6fe7-9b4f-47df-d354-7e43e1de6b6f/859708139310_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a569.phobos.apple.com/us/r30/Music/25/81/4e/mzi.pdaovmcd.aac.p.m4a",
       "trackName"=>"Lullaby"},
     "81"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/28/af/6f/28af6fe7-9b4f-47df-d354-7e43e1de6b6f/859708139310_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a395.phobos.apple.com/us/r30/Music/9a/c7/5a/mzi.gfzghztw.aac.p.m4a",
       "trackName"=>"In My Pocket"},
     "82"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/28/af/6f/28af6fe7-9b4f-47df-d354-7e43e1de6b6f/859708139310_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1846.phobos.apple.com/us/r30/Music/f9/2a/77/mzi.zmkwkqny.aac.p.m4a",
       "trackName"=>"The Night That Never End"},
     "83"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/28/af/6f/28af6fe7-9b4f-47df-d354-7e43e1de6b6f/859708139310_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a918.phobos.apple.com/us/r30/Music/8d/19/9f/mzi.yzghglrh.aac.p.m4a",
       "trackName"=>"Party Started"},
     "84"=>
      {"artworkUrl100"=>
        "http://a2.mzstatic.com/us/r30/Music/v4/28/af/6f/28af6fe7-9b4f-47df-d354-7e43e1de6b6f/859708139310_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1856.phobos.apple.com/us/r30/Music/fa/a5/63/mzi.pliqpfll.aac.p.m4a",
       "trackName"=>"Saltwater"},
     "85"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a446.phobos.apple.com/us/r30/Music/a5/36/95/mzi.raqcevgv.aac.p.m4a",
       "trackName"=>"Fishies"},
     "86"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1120.phobos.apple.com/us/r30/Music/96/a5/3b/mzi.qeanjwtd.aac.p.m4a",
       "trackName"=>"So Long"},
     "87"=>
      {"artworkUrl100"=>
        "http://a1.mzstatic.com/us/r30/Music/fb/7d/8e/mzi.osmqbehd.100x100-75.jpg",
       "previewUrl"=>
        "http://a264.phobos.apple.com/us/r1000/102/Music/v4/5a/3d/79/5a3d79f0-d809-b3a4-8b99-4fef5cf5be5a/mzaf_2333738897625334555.aac.m4a",
       "trackName"=>"Zero"},
     "88"=>
      {"artworkUrl100"=>
        "http://a1.mzstatic.com/us/r30/Music/v4/4f/a0/c3/4fa0c3c0-ab06-db74-010c-62b8dc2f1e24/888608528177.100x100-75.jpg",
       "previewUrl"=>
        "http://a1598.phobos.apple.com/us/r1000/042/Music6/v4/b1/46/ad/b146adf4-9596-c105-1cd7-8069c7adb757/mzaf_1254181040274359673.plus.aac.p.m4a",
       "trackName"=>"Brighter Than Gold"},
     "89"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a877.phobos.apple.com/us/r30/Music/74/67/55/mzi.tmuzdhli.aac.p.m4a",
       "trackName"=>"So Many Nights"},
     "90"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1466.phobos.apple.com/us/r30/Music/bd/c8/8c/mzi.wynroahh.aac.p.m4a",
       "trackName"=>"No Longer There"},
     "91"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1899.phobos.apple.com/us/r30/Music/db/46/fd/mzi.jyadxczx.aac.p.m4a",
       "trackName"=>"Strong Coffee"},
     "92"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1821.phobos.apple.com/us/r30/Music/66/32/dc/mzi.kxjvkxcp.aac.p.m4a",
       "trackName"=>"Sunny Moon"},
     "93"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a918.phobos.apple.com/us/r30/Music/e1/71/77/mzi.ukcwkplk.aac.p.m4a",
       "trackName"=>"Til the Ocean Takes Us All"},
     "94"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1203.phobos.apple.com/us/r30/Music/bc/ac/1d/mzi.pdfsiqrt.aac.p.m4a",
       "trackName"=>"Lonely Moon"},
     "95"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a887.phobos.apple.com/us/r30/Music/c5/f6/01/mzi.nxnxfhak.aac.p.m4a",
       "trackName"=>"The Darkness"},
     "96"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1962.phobos.apple.com/us/r30/Music/83/03/59/mzi.twghqzqp.aac.p.m4a",
       "trackName"=>"Voodoo Cowboy"},
     "97"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1771.phobos.apple.com/us/r30/Music/6f/3a/6b/mzi.teggnujq.aac.p.m4a",
       "trackName"=>"Won't Be Afraid"},
     "98"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a920.phobos.apple.com/us/r30/Music/58/24/72/mzi.wihxvdyc.aac.p.m4a",
       "trackName"=>"No Mountain"},
     "99"=>
      {"artworkUrl100"=>
        "http://a3.mzstatic.com/us/r30/Music/v4/83/f7/63/83f76364-0c07-68ac-15cf-1aa2bd25cfc9/859708139372_cover.100x100-75.jpg",
       "previewUrl"=>
        "http://a1420.phobos.apple.com/us/r30/Music/ac/60/81/mzi.lehqsqgj.aac.p.m4a",
       "trackName"=>"Radio Song"}}}

artist_and_track_data = artist_and_track_data.with_indifferent_access

# pp cat_empire_data_form_fontend
include ApplicationHelper

artist = Artist.new(artist_attribs_from_params(artist_and_track_data))
initialize_new_artist_tracks(artist, artist_and_track_data[:list])

pp artist

# write some asserts against data
