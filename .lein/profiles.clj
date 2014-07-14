{:user {:plugins [[lein-localrepo "0.4.1"]
                  [lein-pprint "1.1.1"]
                  [lein-oneoff "0.2.0"]
                  [lein-outdated "1.0.0"]
                  [lein-depgraph "0.1.0"]
                  [lein-typed "0.3.1"]]
        :source-paths ["dev"]
        :dependencies [[org.clojure/tools.trace "0.7.8"]
                       [org.clojure/tools.namespace "0.2.4"]
                       [org.clojure/java.classpath "0.2.2"]
                       [criterium "0.4.3"]
                       [org.clojure/core.typed "0.2.56"]]
        ; :repositories [["tools.namespace" "https://oss.sonatype.org/content/groups/public/"]]
        :repl-options {:init-ns user}}}
