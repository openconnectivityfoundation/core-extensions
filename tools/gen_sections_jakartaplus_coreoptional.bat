
rem =============================================================
rem batch file that creates the resource sections - Core Optional
rem =============================================================

set Template="<path to local instance of the repo>\swagger2doc\input\ResourceTemplate.docx"

set cmd=python.exe  <path to local instance of the repo>\swagger2doc\src\swagger2doc.py

rem make sure that correct template is used
copy %Template%  .\ResourceTemplate.docx

rem Resources 
%cmd% -swagger oic.wk.con.swagger.json -resource exampleDeviceConfigurationResURI -docx ResourceTemplate.docx -word_out first.swagger.docx -annex True
%cmd% -swagger oic.wk.con.p.swagger.json -resource examplePlatformConfigurationResURI -docx first.swagger.docx -word_out second.swagger.docx -annex True
%cmd% -swagger oic.r.icon.swagger.json -resource IconResURI -docx second.swagger.docx -word_out icon.swagger.docx -annex True
%cmd% -swagger oic.wk.mnt.swagger.json -resource oic/mnt -docx icon.swagger.docx -word_out mnt.swagger.docx -annex True -wellknown True
%cmd% -swagger oic.wk.nmon.swagger.json -resource nmonResURI -docx mnt.swagger.docx -word_out nmon.swagger.docx -annex True
%cmd% -swagger oic.wk.scenelist.swagger.json -resource SceneListResURI?if=oic.if.baseline -docx nmon.swagger.docx -word_out scenelist.swagger.docx -annex True
%cmd% -swagger oic.wk.scenecollection.swagger.json -resource SceneCollectionResURI?if=oic.if.baseline -docx scenelist.swagger.docx -word_out scenecollection.swagger.docx -annex True
%cmd% -swagger oic.wk.scenemember.swagger.json -resource SceneMemberResURI -docx scenecollection.swagger.docx -word_out scenemember.swagger.docx -annex True
%cmd% -swagger oic.r.alert.swagger.json -resource AlertResURI -docx scenemember.swagger.docx -word_out alert.swagger.docx -annex True
%cmd% -swagger oic.r.alertcollection.swagger.json -resource AlertCollectionResURI?if=oic.if.baseline -docx alert.swagger.docx -word_out alertcollection.swagger.docx -annex True
%cmd% -swagger oic.r.softwareupdate.swagger.json -resource softwareupdateResURI -docx alertcollection.swagger.docx -word_out swupd.swagger.docx -annex True
%cmd% -swagger oic.r.rule.swagger.json -resource RuleResURI?if=oic.if.baseline -docx swupd.swagger.docx -word_out rule.swagger.docx -annex True
%cmd% -swagger oic.r.rule.inputcollection.swagger.json -resource RuleInputCollectionResURI?if=oic.if.baseline -docx rule.swagger.docx -word_out ruleic.swagger.docx -annex True
%cmd% -swagger oic.r.rule.expression.swagger.json -resource RuleExpressionResURI -docx ruleic.swagger.docx -word_out rulee.swagger.docx -annex True
%cmd% -swagger oic.r.rule.actioncollection.swagger.json -resource RuleActionCollectionResURI?if=oic.if.baseline -docx rulee.swagger.docx -word_out ruleac.swagger.docx -annex True
%cmd% -swagger oic.r.rule.action.swagger.json -resource RuleActionResURI -docx ruleac.swagger.docx -word_out rulea.swagger.docx -annex True
%cmd% -swagger oic.r.groups.swagger.json -resource groupsResURI -docx rulea.swagger.docx -word_out groups.swagger.docx -annex True

copy  groups.swagger.docx coreoptional.generated.docx
del -f *.swagger.docx

:end
