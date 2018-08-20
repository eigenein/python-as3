package game.mediator.gui.popup.mail
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.common.social.GMRSocialAdapter;
   import com.progrestar.common.social.SocialAdapter;
   import engine.context.platform.PlatformUser;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.mechanics.clan_war.storage.ClanWarLeagueDescription;
   import game.model.GameModel;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.mail.PlayerMailEntry;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class PlayerMailEntryTranslation
   {
       
      
      public function PlayerMailEntryTranslation()
      {
         super();
      }
      
      public static function getButtonActions(param1:PlayerMailEntry) : Vector.<PlayerMailButtonAction>
      {
         var _loc2_:Vector.<PlayerMailButtonAction> = new Vector.<PlayerMailButtonAction>();
         var _loc3_:* = param1.type;
         if("dataProtectionLaw" === _loc3_)
         {
            _loc2_.push(new PlayerMailButtonAction(Translate.translate("LIB_MAIL_TYPE_DATAPROTECTIONLAW_DEFAULT_BUTTON1"),null,null));
            _loc2_.push(new PlayerMailButtonAction(Translate.translate("LIB_MAIL_TYPE_DATAPROTECTIONLAW_DEFAULT_BUTTON2"),PlayerMailButtonAction.action_EUProtectionLaw,{"url":param1.params.url}));
         }
         return _loc2_;
      }
      
      public static function translateTitle(param1:PlayerMailEntry) : String
      {
         var _loc2_:Array = [];
         var _loc3_:String = "default";
         var _loc5_:* = param1.type;
         if("fireworksGift" !== _loc5_)
         {
            if("clanWarPromote" !== _loc5_)
            {
               if("clanWarDaily" !== _loc5_)
               {
                  if("clanDungeonActivity" !== _loc5_)
                  {
                     if("arenaTier" !== _loc5_)
                     {
                        if("freebie" === _loc5_)
                        {
                           if(param1.params.channel == "group")
                           {
                              if(checkRewardForBronzeCaskets(param1))
                              {
                                 _loc3_ = "group_casket";
                              }
                              else
                              {
                                 _loc3_ = "group";
                              }
                           }
                        }
                     }
                     else
                     {
                        _loc2_ = [param1.params.tier];
                     }
                  }
                  else
                  {
                     _loc2_ = [param1.params.points];
                  }
               }
               else if(param1.params.result == "win")
               {
                  if(param1.params.isChampion)
                  {
                     _loc3_ = "champion_victory";
                  }
                  else
                  {
                     _loc3_ = "victory";
                  }
               }
               else if(param1.params.result == "lose")
               {
                  _loc3_ = "defeat";
               }
               else
               {
                  _loc3_ = "draw";
               }
            }
            else if(param1.params.oldLeague > param1.params.currentLeague)
            {
               _loc3_ = "up_league_" + param1.params.currentLeague;
            }
            else
            {
               _loc3_ = "down_league_" + param1.params.currentLeague;
            }
         }
         else
         {
            _loc2_ = [param1.params.nickname];
            if(param1.params.clanTitle)
            {
               _loc2_[1] = param1.params.clanTitle;
            }
            if(param1.params.nickname && param1.params.clanTitle)
            {
               _loc3_ = "clan";
            }
            if(param1.params.clanTitle && !param1.params.nickname)
            {
               _loc3_ = "clan_only";
            }
            if(!param1.params.clanTitle && !param1.params.nickname)
            {
               _loc3_ = "anonymous";
            }
         }
         var _loc4_:String = "LIB_MAIL_TYPE_" + param1.type.toUpperCase() + "_" + _loc3_.toUpperCase() + "_TITLE";
         if(_loc2_.length)
         {
            _loc2_.unshift(_loc4_);
            return Translate.translateArgs.apply(null,_loc2_);
         }
         return Translate.translate(_loc4_);
      }
      
      public static function translateText(param1:PlayerMailEntry) : String
      {
         var _loc14_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:* = null;
         var _loc6_:* = null;
         var _loc13_:* = null;
         if(param1.message)
         {
            return param1.message;
         }
         var _loc11_:Array = [];
         var _loc3_:String = "default";
         var _loc16_:* = param1.type;
         if("oldQuest" !== _loc16_)
         {
            if("fireworksGift" !== _loc16_)
            {
               if("clanWarPromote" !== _loc16_)
               {
                  if("artifactChestLevelUp" !== _loc16_)
                  {
                     if("clanWarDaily" !== _loc16_)
                     {
                        if("clanWarWeekly" !== _loc16_)
                        {
                           if("test" !== _loc16_)
                           {
                              if("clanActivity" !== _loc16_)
                              {
                                 if("clanDungeonActivity" !== _loc16_)
                                 {
                                    if("promoteGift" !== _loc16_)
                                    {
                                       if("mass" !== _loc16_)
                                       {
                                          if("massImportant" !== _loc16_)
                                          {
                                             if("user" !== _loc16_)
                                             {
                                                if("arenaTier" !== _loc16_)
                                                {
                                                   if("arena" !== _loc16_)
                                                   {
                                                      if("top" !== _loc16_)
                                                      {
                                                         if("dailyGift" !== _loc16_)
                                                         {
                                                            if("freebie" !== _loc16_)
                                                            {
                                                               if("serverMergeStarmoney" !== _loc16_)
                                                               {
                                                                  if("serverMerge" === _loc16_)
                                                                  {
                                                                     _loc6_ = param1.params.mainServer + "(" + Translate.translate("LIB_SERVER_NAME_" + param1.params.mainServer) + ")";
                                                                     _loc13_ = param1.params.joinServer + "(" + Translate.translate("LIB_SERVER_NAME_" + param1.params.joinServer) + ")";
                                                                     _loc11_ = [_loc6_,_loc13_];
                                                                     if(checkRewardForGrandCoins(param1))
                                                                     {
                                                                        _loc3_ = "grand_coin";
                                                                     }
                                                                  }
                                                               }
                                                            }
                                                            else if(param1.params.channel == "group")
                                                            {
                                                               if(checkRewardForBronzeCaskets(param1))
                                                               {
                                                                  _loc3_ = "group_casket";
                                                               }
                                                               else
                                                               {
                                                                  _loc3_ = "group";
                                                               }
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc12_ = GameModel.instance.context.platformFacade.getPlatformUserById(param1.params.accountId);
                                                            if(_loc12_)
                                                            {
                                                               _loc11_ = [_loc12_.realName];
                                                            }
                                                            else
                                                            {
                                                               _loc11_ = [];
                                                            }
                                                         }
                                                      }
                                                      else
                                                      {
                                                         _loc10_ = param1.params.grand;
                                                         _loc9_ = param1.params.arena;
                                                         if(_loc10_)
                                                         {
                                                            if(_loc10_ > _loc9_)
                                                            {
                                                               _loc3_ = "arena_w_grand_2";
                                                            }
                                                            else
                                                            {
                                                               _loc3_ = "arena_w_grand_1";
                                                            }
                                                            _loc11_ = [_loc9_,_loc10_];
                                                         }
                                                         else
                                                         {
                                                            _loc11_ = [_loc9_];
                                                         }
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _loc11_ = [param1.params.lastBest,param1.params.best];
                                                   }
                                                }
                                                else
                                                {
                                                   _loc11_ = [param1.params.tier];
                                                }
                                             }
                                          }
                                       }
                                    }
                                    else
                                    {
                                       _loc8_ = DataStorage.hero.getHeroById(param1.params.hero);
                                       _loc7_ = DataStorage.enum.getById_HeroColor(param1.params.toColor);
                                       _loc11_ = [Translate.genderTriggerString(_loc8_.perks.isMale),Translate.genderTriggerString(_loc8_.perks.isMale),ColorUtils.hexToRGBFormat(_loc7_.textColor) + _loc7_.fullName + ColorUtils.hexToRGBFormat(16573879),ColorUtils.hexToRGBFormat(16645626) + _loc8_.name + ColorUtils.hexToRGBFormat(16573879)];
                                    }
                                 }
                              }
                              _loc11_ = [param1.params.points];
                           }
                        }
                        else
                        {
                           _loc4_ = DataStorage.clanWar.getLeagueById(param1.params.league);
                           _loc5_ = !!_loc4_?_loc4_.name:"";
                           _loc11_ = [_loc5_,param1.params.position,param1.params.division];
                        }
                     }
                     else if(param1.params.result == "win")
                     {
                        if(param1.params.isChampion)
                        {
                           _loc3_ = "champion_victory";
                        }
                        else
                        {
                           _loc3_ = "victory";
                        }
                     }
                     else if(param1.params.result == "lose")
                     {
                        _loc3_ = "defeat";
                     }
                     else
                     {
                        _loc3_ = "draw";
                     }
                  }
                  else
                  {
                     _loc11_ = [param1.params.nickname,param1.params.level];
                  }
               }
               else
               {
                  if(param1.params.oldLeague > param1.params.currentLeague)
                  {
                     _loc3_ = "up_league_" + param1.params.currentLeague;
                  }
                  else
                  {
                     _loc3_ = "down_league_" + param1.params.currentLeague;
                  }
                  _loc2_ = DataStorage.clanWar.getLeagueById(param1.params.currentLeague);
                  if(_loc2_)
                  {
                     _loc11_ = [_loc2_.maxChampions];
                  }
               }
            }
            else
            {
               _loc11_ = [param1.params.nickname];
               if(param1.params.clanTitle)
               {
                  _loc11_[1] = param1.params.clanTitle;
               }
               if(param1.params.nickname && param1.params.clanTitle)
               {
                  _loc3_ = "clan";
               }
               if(param1.params.clanTitle && !param1.params.nickname)
               {
                  _loc3_ = "clan_only";
               }
               if(!param1.params.clanTitle && !param1.params.nickname)
               {
                  _loc3_ = "anonymous";
               }
            }
         }
         else
         {
            _loc14_ = Translate.translate(DataStorage.specialQuestEvent.getEventNameLocaleKeyById(param1.params.eventId));
            _loc11_ = [Translate.genderTriggerString(GameModel.instance.context.platformFacade.user.male),_loc14_];
         }
         var _loc15_:String = "LIB_MAIL_TYPE_" + param1.type.toUpperCase() + "_" + _loc3_.toUpperCase() + "_TEXT";
         if(param1.type == "registrationGift" && SocialAdapter.instance is GMRSocialAdapter)
         {
            _loc15_ = "LIB_MAIL_TYPE_" + param1.type.toUpperCase() + "_" + _loc3_.toUpperCase() + "_TEXT" + "_GMR";
         }
         if(_loc11_.length)
         {
            _loc11_.unshift(_loc15_);
            return Translate.translateArgs.apply(null,_loc11_);
         }
         return Translate.translate(_loc15_);
      }
      
      private static function checkRewardForGrandCoins(param1:PlayerMailEntry) : Boolean
      {
         var _loc5_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(param1.reward)
         {
            _loc5_ = param1.reward.outputDisplay;
            _loc3_ = _loc5_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = _loc5_[_loc4_].item as CoinDescription;
               if(_loc2_ && _loc2_.ident == "grand_arena")
               {
                  return true;
               }
               _loc4_++;
            }
         }
         return false;
      }
      
      private static function checkRewardForBronzeCaskets(param1:PlayerMailEntry) : Boolean
      {
         var _loc5_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(param1.reward)
         {
            _loc5_ = param1.reward.outputDisplay;
            _loc3_ = _loc5_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = _loc5_[_loc4_].item as ConsumableDescription;
               if(_loc2_ && _loc2_.rewardType == "lootBox")
               {
                  return true;
               }
               _loc4_++;
            }
         }
         return false;
      }
   }
}
