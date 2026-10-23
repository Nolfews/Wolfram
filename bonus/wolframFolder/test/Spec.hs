import Test.HUnit
import Lib

testConfParsing :: Test
testConfParsing = TestList
    [ "Valid rule 30"  ~: getOpts defaultConf ["--rule", "30"] ~?= Just (defaultConf { rule = Just 30 })
    , "Invalid rule"   ~: getOpts defaultConf ["--rule", "99"] ~?= Nothing
    , "Missing rule"   ~: getOpts defaultConf [] ~?= Nothing
    ]

main :: IO ()
main = do
    counts <- runTestTT testConfParsing
    if errors counts + failures counts == 0 then return () else exitWith (ExitFailure 84)
