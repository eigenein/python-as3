package game.data.storage.quest
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.titan.TitanDescription;
   import game.data.storage.world.WorldMapDescription;
   import game.mechanics.boss.storage.BossTypeDescription;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class QuestDescriptionTaskTranslation
   {
       
      
      public function QuestDescriptionTaskTranslation(param1:Object)
      {
         super();
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in param1)
         {
         }
      }
      
      public function translateTask(param1:QuestDescription) : String
      {
         return translateCondition(param1.farmCondition,param1.translationMethod);
      }
      
      public function translateCondition(param1:QuestConditionDescription, param2:String) : String
      {
         var _loc9_:* = null;
         var _loc14_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc15_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = null;
         var _loc16_:* = undefined;
         var _loc17_:int = 0;
         var _loc12_:* = null;
         var _loc13_:int = 0;
         var _loc5_:* = null;
         var _loc4_:String = "LIB_QUEST_TRANSLATE_" + param2.toUpperCase();
         var _loc3_:Array = [];
         var _loc18_:* = param2;
         if("titanArtifactAmountStarsById" !== _loc18_)
         {
            if("titanArtifactAmountLevel" !== _loc18_)
            {
               if("titanArtifactAmountStars" !== _loc18_)
               {
                  if("specialQuestFarmByEventTypeId" !== _loc18_)
                  {
                     if("artifactAmountStars" !== _loc18_)
                     {
                        if("artifactUpgrade" !== _loc18_)
                        {
                           if("heroAmountStars" !== _loc18_)
                           {
                              if("arenaPlace" !== _loc18_)
                              {
                                 if("grandArenaPlace" !== _loc18_)
                                 {
                                    if("eventRatingQuizPlace" !== _loc18_)
                                    {
                                       if("eventRatingSendPlace" !== _loc18_)
                                       {
                                          if("eventRatingTakePlace" !== _loc18_)
                                          {
                                             if("titanGiftLevelCount" !== _loc18_)
                                             {
                                                if("titanStarsCount" !== _loc18_)
                                                {
                                                   if("heroQualityCount" !== _loc18_)
                                                   {
                                                      if("heroByNameColor" !== _loc18_)
                                                      {
                                                         if("teamLevel" !== _loc18_)
                                                         {
                                                            if("heroAmount" !== _loc18_)
                                                            {
                                                               if("heroUpgradeSkillCount" !== _loc18_)
                                                               {
                                                                  if("missionCompleteAny" !== _loc18_)
                                                                  {
                                                                     if("missionCompleteEliteAny" !== _loc18_)
                                                                     {
                                                                        if("arenaBattleCount" !== _loc18_)
                                                                        {
                                                                           if("heroEnchantItemCount" !== _loc18_)
                                                                           {
                                                                              if("alchemyCount" !== _loc18_)
                                                                              {
                                                                                 if("chestOpenCount" !== _loc18_)
                                                                                 {
                                                                                    if("socialGifts" !== _loc18_)
                                                                                    {
                                                                                       if("raidMissionCompleteAny" !== _loc18_)
                                                                                       {
                                                                                          if("bossChest" !== _loc18_)
                                                                                          {
                                                                                             if("worldCompleteName" !== _loc18_)
                                                                                             {
                                                                                                if("missionCompleteNameCount" !== _loc18_)
                                                                                                {
                                                                                                   if("missionCompleteName" !== _loc18_)
                                                                                                   {
                                                                                                      if("heroByIdName" !== _loc18_)
                                                                                                      {
                                                                                                         if("heroByNamePurple" !== _loc18_)
                                                                                                         {
                                                                                                            if("heroByNameOrange" !== _loc18_)
                                                                                                            {
                                                                                                               if("freeStaminaHours" !== _loc18_)
                                                                                                               {
                                                                                                                  if("starmoneySubscription" !== _loc18_)
                                                                                                                  {
                                                                                                                     if("raidVipTickets" !== _loc18_)
                                                                                                                     {
                                                                                                                        if("runeLevelCount" !== _loc18_)
                                                                                                                        {
                                                                                                                           if("runeLevelCount" !== _loc18_)
                                                                                                                           {
                                                                                                                              if("heroSkinAmountByLevel" !== _loc18_)
                                                                                                                              {
                                                                                                                                 if("heroSkinLevelById" !== _loc18_)
                                                                                                                                 {
                                                                                                                                    if("bossKillByLevel" !== _loc18_)
                                                                                                                                    {
                                                                                                                                       if("towerFloor" !== _loc18_)
                                                                                                                                       {
                                                                                                                                          _loc3_[0] = param1.amount;
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          _loc3_[0] = param1.functionArgs.floorNumber;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       _loc13_ = param1.functionArgs.id;
                                                                                                                                       _loc5_ = DataStorage.boss.getByType(_loc13_);
                                                                                                                                       if(_loc5_)
                                                                                                                                       {
                                                                                                                                          _loc3_[0] = _loc5_.name;
                                                                                                                                          _loc3_[1] = param1.functionArgs.level;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    _loc8_ = DataStorage.skin.getById(param1.functionArgs.skinId) as SkinDescription;
                                                                                                                                    if(_loc8_)
                                                                                                                                    {
                                                                                                                                       _loc3_[0] = _loc8_.name;
                                                                                                                                       _loc7_ = DataStorage.hero.getUnitById(_loc8_.heroId);
                                                                                                                                       if(_loc7_)
                                                                                                                                       {
                                                                                                                                          _loc3_[1] = _loc7_.name;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    _loc3_[2] = param1.amount;
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 _loc3_[0] = param1.amount;
                                                                                                                                 _loc3_[1] = param1.functionArgs.level;
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              _loc3_[0] = param1.amount;
                                                                                                                              _loc3_[1] = param1.functionArgs.level;
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           _loc3_ = [param1.amount,param1.functionArgs.level];
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        _loc3_[0] = "n";
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     _loc3_[0] = "n";
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  _loc3_ = [param1.functionArgs.startHour + ":00",param1.functionArgs.endHour + ":00"];
                                                                                                               }
                                                                                                            }
                                                                                                         }
                                                                                                         addr394:
                                                                                                         _loc7_ = DataStorage.hero.getUnitById(param1.functionArgs.id);
                                                                                                         if(_loc7_)
                                                                                                         {
                                                                                                            _loc3_[0] = _loc7_.name;
                                                                                                         }
                                                                                                      }
                                                                                                      §§goto(addr394);
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      _loc9_ = DataStorage.mission.getMissionById(param1.functionArgs.id) as MissionDescription;
                                                                                                      if(_loc9_)
                                                                                                      {
                                                                                                         _loc3_[0] = _loc9_.name;
                                                                                                      }
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   _loc9_ = DataStorage.mission.getMissionById(param1.functionArgs.id) as MissionDescription;
                                                                                                   if(_loc9_)
                                                                                                   {
                                                                                                      _loc3_[1] = _loc9_.name;
                                                                                                   }
                                                                                                   _loc3_[0] = param1.amount;
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                _loc9_ = DataStorage.mission.getMissionById(param1.functionArgs.id) as MissionDescription;
                                                                                                _loc14_ = DataStorage.world.getById(_loc9_.world) as WorldMapDescription;
                                                                                                if(_loc14_)
                                                                                                {
                                                                                                   _loc3_[0] = _loc14_.id;
                                                                                                   _loc3_[1] = _loc14_.name;
                                                                                                }
                                                                                             }
                                                                                          }
                                                                                       }
                                                                                       addr309:
                                                                                       _loc3_[0] = param1.amount;
                                                                                    }
                                                                                    addr308:
                                                                                    §§goto(addr309);
                                                                                 }
                                                                                 addr307:
                                                                                 §§goto(addr308);
                                                                              }
                                                                              addr306:
                                                                              §§goto(addr307);
                                                                           }
                                                                           addr305:
                                                                           §§goto(addr306);
                                                                        }
                                                                        addr304:
                                                                        §§goto(addr305);
                                                                     }
                                                                     addr303:
                                                                     §§goto(addr304);
                                                                  }
                                                                  addr302:
                                                                  §§goto(addr303);
                                                               }
                                                               addr301:
                                                               §§goto(addr302);
                                                            }
                                                            addr300:
                                                            §§goto(addr301);
                                                         }
                                                         §§goto(addr300);
                                                      }
                                                      else
                                                      {
                                                         _loc17_ = param1.functionArgs.id;
                                                         _loc12_ = DataStorage.hero.getUnitById(_loc17_);
                                                         _loc3_[0] = _loc12_.name;
                                                         _loc6_ = DataStorage.enum.getById_HeroColor(param1.functionArgs.color);
                                                         _loc15_ = uint(16375461);
                                                         _loc10_ = uint(_loc6_.textColor);
                                                         if(_loc6_)
                                                         {
                                                            _loc3_[1] = ColorUtils.hexToRGBFormat(_loc10_) + _loc6_.fullName + ColorUtils.hexToRGBFormat(_loc15_);
                                                         }
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _loc3_[0] = param1.amount;
                                                      _loc6_ = DataStorage.enum.getById_HeroColor(param1.functionArgs.color);
                                                      _loc15_ = uint(16375461);
                                                      _loc10_ = uint(_loc6_.textColor);
                                                      if(_loc6_)
                                                      {
                                                         _loc3_[1] = ColorUtils.hexToRGBFormat(_loc10_) + _loc6_.fullName + ColorUtils.hexToRGBFormat(_loc15_);
                                                      }
                                                   }
                                                }
                                                else
                                                {
                                                   _loc3_[0] = param1.amount;
                                                   _loc3_[1] = param1.functionArgs.star;
                                                }
                                             }
                                             else
                                             {
                                                _loc3_[0] = param1.amount;
                                                _loc3_[1] = param1.functionArgs.level;
                                             }
                                          }
                                       }
                                       addr179:
                                       _loc3_[0] = param1.functionArgs.place;
                                    }
                                    addr178:
                                    §§goto(addr179);
                                 }
                                 addr177:
                                 §§goto(addr178);
                              }
                              §§goto(addr177);
                           }
                           else
                           {
                              _loc3_[0] = param1.amount;
                              _loc3_[1] = param1.functionArgs.star;
                           }
                        }
                        else
                        {
                           _loc3_[0] = param1.amount;
                           _loc3_[1] = param1.functionArgs.level;
                        }
                     }
                     else
                     {
                        _loc3_[0] = param1.amount;
                        _loc3_[1] = param1.functionArgs.star;
                     }
                  }
                  else
                  {
                     _loc3_[0] = param1.amount;
                     _loc3_[1] = DataStorage.specialQuestEvent.getEventNameLocaleKeyById(param1.functionArgs.specialQuestEventTypeId);
                  }
               }
               else
               {
                  _loc3_[0] = param1.amount;
                  _loc3_[1] = param1.functionArgs.star;
               }
            }
            else
            {
               _loc3_[0] = param1.amount;
               _loc3_[1] = param1.functionArgs.level;
            }
         }
         else
         {
            _loc11_ = DataStorage.titanArtifact.getById(param1.functionArgs.id) as TitanArtifactDescription;
            _loc3_[0] = !!_loc11_?_loc11_.name:"?";
            if(_loc11_)
            {
               _loc16_ = DataStorage.titanArtifact.getTitanByArtifact(_loc11_);
            }
            _loc3_[1] = _loc16_ && _loc16_.length?_loc16_[0].name:"?";
            _loc3_[2] = int(param1.amount);
         }
         _loc3_.unshift(_loc4_);
         return Translate.translateArgs.apply(this,_loc3_);
      }
   }
}
