(defproject jepsen-docker "0.1.0-SNAPSHOT"
  :description "Jepsen setup for docker."
  :dependencies [[jepsen "0.3.7"]
                 [org.clojure/clojure "1.12.0"]
                 [org.clojure/data.fressian "1.0.0"]
                 [org.clojure/tools.logging "1.2.4"]
                 [org.clojure/tools.cli "1.0.219"]
                 [spootnik/unilog "0.7.31"
                  :exclusions [org.slf4j/slf4j-api]]
                 [elle "0.2.2"]
                 [clj-time "0.15.2"]
                 [io.jepsen/history "0.1.4"]
                 [jepsen.txn "0.1.2"]
                 [knossos "0.3.11"]
                 [clj-ssh "0.5.14"]
                 [gnuplot "0.1.3"]
                 [http-kit "2.7.0"]
                 [ring "1.11.0"]
                 [com.hierynomus/sshj "0.38.0"]
                 [com.jcraft/jsch.agentproxy.connector-factory "0.0.9"]
                 [com.jcraft/jsch.agentproxy.sshj "0.0.9"
                  :exclusions [net.schmizz/sshj]]
                 [org.bouncycastle/bcprov-jdk15on "1.70"]
                 [hiccup "1.0.5"]
                 [metametadata/multiset "0.1.1"]
                 [byte-streams "0.2.5-alpha2"]
                 [slingshot "0.12.2"]
                 [org.clojure/data.codec "0.1.1"]
                 [fipp "0.6.26"]])
