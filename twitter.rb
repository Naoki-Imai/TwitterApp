require 'launchy'
require "time"

def showMenus(menus, menuIndex)
  
  for showMenu in menus do
    puts "[#{menuIndex.to_s}]:#{showMenu[:menu]}"
    menuIndex += 1
  end
  puts "[0]Twitterを開く"
  puts "[その他]アプリを終了する"
  print "メニューから選択してください："
  @selectMenu = gets.chomp.to_s
end

def addTweet(twitter)
  print "タイトルを入力してください："
  title = gets.chomp
  print "内容を入力してください："
  tweet = gets.chomp
  t = Time.now
  puts "タイトル：#{title}"
  puts "ツイート内容：#{tweet}"
  print "上記内容で登録します。よろしければyを入れてください："

  add = gets.chomp
  # 追加する
  if add == "y"
    twitter.push({title: title, tweet: tweet, date: t.strftime("%Y-%m-%d %H:%M:%S")})
    showTweet(twitter)
  else
    puts "メニューに戻ります"
  end
end

def showTweet(twitter)
  if twitter.empty?
    puts "ツイートがありません"
  else
    twitterIndex = 1
    twitterLength = twitter.length
    puts "★All Tweets #{twitterLength}★"
    puts '--------------------'
    for i in twitter do
      puts "NO.#{twitterIndex.to_s} 投稿時刻：#{i[:date]}"
      puts i[:title]
      puts i[:tweet]
      twitterIndex += 1
      puts '--------------------'
    end
  end
end

def removeTweet(twitter)
  showTweet(twitter)
  print "ツイートを削除します\n削除したい番号を入力してください："
  deleteItem = gets.chomp.to_i - 1
  print "#{twitter[deleteItem][:title]}\n#{twitter[deleteItem][:tweet]}\nを削除しますよろしいですか？（y or n)："
  remove = gets.chomp
  if remove == "y"
    puts "#{twitter[deleteItem][:title]}\n#{twitter[deleteItem][:tweet]}\nを削除しました"
    twitter.delete_at(deleteItem)
    puts "現在のツイート"
    showTweet(twitter)
    return true
  else
    #メニューに戻る
    puts "メニューに戻ります"
  end

end

twitter = []
menus = [
  {menu:"ツイートする"},
  {menu:"ツイート一覧をみる"},
  {menu:"ツイートを削除する"}
]
menuIndex = 1
continue = true


while continue
  
  showMenus(menus, menuIndex)

  if @selectMenu == "1"
    addTweet(twitter)

  elsif @selectMenu == "2"
    showTweet(twitter)

  elsif @selectMenu == "3"
    removeTweet(twitter)
  elsif @selectMenu == "0"
    Launchy.open "https://twitter.com/home?lang=ja"
  else
    puts "アプリを終了します"
    return false
  end
end


