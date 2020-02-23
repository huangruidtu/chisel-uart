
scalaVersion := "2.11.7"

// latest Chisel 2 version
// libraryDependencies += "edu.berkeley.cs" %% "chisel" % "2.2.38"

resolvers ++= Seq(
  Resolver.sonatypeRepo("snapshots"),
  Resolver.sonatypeRepo("releases")
)

// some issue with tester and wave form
 libraryDependencies += "edu.berkeley.cs" %% "chisel3" % "3.1.8"
 libraryDependencies += "edu.berkeley.cs" %% "chisel-iotesters" % "1.2.10"

// libraryDependencies += "edu.berkeley.cs" %% "chisel3" % "3.1.3"
// libraryDependencies += "edu.berkeley.cs" %% "chisel-iotesters" % "1.2.2"

// libraryDependencies += "edu.berkeley.cs" %% "chisel3" % "latest.release"
// libraryDependencies += "edu.berkeley.cs" %% "chisel-iotesters" % "latest.release"

libraryDependencies += "org.scalatest" %% "scalatest" % "3.0.5" % "test"
