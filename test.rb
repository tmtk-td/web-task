# gem install webrickでインストールされたライブラリ「webrick」を呼び出し
require 'webrick'
# Webrickのインスタンスを作成し、serverという名前のローカル変数に入れます。
# DocumentRoot：このWebアプリケーションのドメインの設定（ここに書き込まれた記述が、作成するWebアプリケーションのドメインになる）
# CGIInterpreter：このプログラムを実行（翻訳）できるプログラム（Rubyのこと）本体の居場所を指定する記述。
# Port：このWebアプリケーションの情報の出入り口を表す設定。
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/test2', WEBrick::HTTPServlet::ERBHandler, 'test2.html.erb')
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.mount('/self_cost.cgi', WEBrick::HTTPServlet::CGIHandler, 'self_cost.rb')
server.start
