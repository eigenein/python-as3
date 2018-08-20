package game.command.rpc.mission
{
   import battle.BattleConfig;
   import engine.context.GameContext;
   import game.battle.controller.thread.BattleThread;
   import game.battle.controller.thread.ClanWarHeroBattleThread;
   import game.battle.controller.thread.ClanWarTitanBattleThread;
   import game.battle.controller.thread.DungeonHeroBattleThread;
   import game.battle.controller.thread.ReplayBattleThread;
   import game.battle.controller.thread.ReplayBossBattleThread;
   import game.battle.controller.thread.ReplayMissionBattleThread;
   import game.battle.controller.thread.ReplayTowerBattleThread;
   import game.battle.controller.thread.TitanArenaBattleThread;
   import game.battle.controller.thread.TitanBattleThread;
   import game.battle.controller.thread.TitanChallengeBattleThread;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupList;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import org.osflash.signals.Signal;
   
   public class CommandBattleStartReplay extends CostCommand
   {
      
      public static const REPLAY_BATTLE_TYPE_MISSION:String = "mission";
      
      public static const REPLAY_BATTLE_TYPE_TOWER:String = "tower";
      
      public static const REPLAY_BATTLE_TYPE_TITAN_TOWER:String = "dungeon_titan";
      
      public static const REPLAY_BATTLE_TYPE_TITAN_PVP:String = "titan_pvp";
      
      public static const REPLAY_BATTLE_TYPE_CLAN_DUNGEON:String = "clan_dungeon";
      
      public static const REPLAY_BATTLE_TYPE_ARENA:String = "arena";
      
      public static const REPLAY_BATTLE_TYPE_GRAND:String = "grand";
      
      public static const REPLAY_BATTLE_TYPE_BOSS:String = "boss";
      
      public static const REPLAY_BATTLE_TYPE_CHALLENGE:String = "challenge";
      
      public static const REPLAY_BATTLE_TYPE_CHALLENGE_TITAN:String = "challenge_titan";
      
      public static const REPLAY_BATTLE_TYPE_CLAN_PVP:String = "clan_pvp";
      
      public static const REPLAY_BATTLE_TYPE_CLAN_PVP_TITAN:String = "clan_pvp_titan";
      
      public static const REPLAY_BATTLE_TYPE_TITAN_ARENA:String = "titan_arena";
      
      public static const REPLAY_BATTLE_TYPE_TITAN_ARENA_DEF:String = "titan_arena_def";
       
      
      public const signal_replayStart:Signal = new Signal();
      
      public const signal_replayComplete:Signal = new Signal(BattleThread);
      
      protected var explicitBattleVersion:int;
      
      protected var explicitBattleType:String;
      
      public function CommandBattleStartReplay(param1:String, param2:int = 0, param3:String = null)
      {
         super();
         this.explicitBattleVersion = param2;
         this.explicitBattleType = param3;
         rpcRequest = new RpcRequest("battleGetReplay");
         rpcRequest.writeParam("id",param1);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc5_:* = null;
         var _loc12_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(!result.body)
         {
            if(GameContext.instance.consoleEnabled)
            {
               PopupList.instance.message("Реплей с заданным id не найден");
            }
            signal_replayComplete.dispatch(new BattleThread(new BattleConfig()));
            signal_replayComplete.removeAll();
            return;
         }
         signal_replayStart.dispatch();
         signal_replayStart.removeAll();
         var _loc7_:Object = result.body.replay;
         var _loc10_:Object = result.body.users;
         if(explicitBattleVersion != 0)
         {
            _loc7_.result.serverVersion = explicitBattleVersion;
         }
         var _loc8_:String = _loc7_.type;
         if(explicitBattleType)
         {
            _loc8_ = explicitBattleType;
         }
         var _loc9_:Object = _loc10_[_loc7_.userId];
         var _loc6_:Object = _loc10_[_loc7_.typeId];
         if(_loc9_ && _loc10_)
         {
            _loc5_ = new UserInfo();
            _loc5_.parse(_loc9_);
         }
         if(_loc6_ && _loc10_)
         {
            _loc12_ = new UserInfo();
            _loc12_.parse(_loc6_);
         }
         var _loc11_:BattleThread = null;
         var _loc14_:* = _loc8_;
         if("mission" !== _loc14_)
         {
            if("clan_dungeon" !== _loc14_)
            {
               if("tower" !== _loc14_)
               {
                  if("challenge" !== _loc14_)
                  {
                     if("arena" !== _loc14_)
                     {
                        if("grand" !== _loc14_)
                        {
                           if("dungeon_titan" !== _loc14_)
                           {
                              if("titan_pvp" !== _loc14_)
                              {
                                 if("challenge_titan" !== _loc14_)
                                 {
                                    if("clan_pvp" !== _loc14_)
                                    {
                                       if("clan_pvp_titan" !== _loc14_)
                                       {
                                          if("titan_arena" !== _loc14_)
                                          {
                                             if("titan_arena_def" !== _loc14_)
                                             {
                                             }
                                          }
                                          _loc11_ = new TitanArenaBattleThread(_loc7_,_loc5_,_loc12_);
                                       }
                                       else
                                       {
                                          _loc11_ = new ClanWarTitanBattleThread(_loc7_,_loc5_,_loc12_);
                                       }
                                    }
                                    else
                                    {
                                       _loc11_ = new ClanWarHeroBattleThread(_loc7_,_loc5_,_loc12_);
                                    }
                                 }
                              }
                              _loc11_ = new TitanChallengeBattleThread(_loc7_,_loc5_,_loc12_);
                           }
                           else
                           {
                              _loc11_ = new TitanBattleThread(_loc7_,_loc7_);
                           }
                        }
                     }
                     _loc11_ = new ReplayBattleThread(_loc7_,false,_loc5_,_loc12_);
                  }
                  else
                  {
                     _loc4_ = 0;
                     _loc14_ = 0;
                     var _loc13_:* = _loc7_.attackers;
                     for each(var _loc2_ in _loc7_.attackers)
                     {
                        _loc4_ = _loc2_.id;
                     }
                     if(DataStorage.hero.getUnitById(_loc4_).unitType == "hero")
                     {
                        _loc11_ = new ReplayBattleThread(_loc7_,false,_loc5_,_loc12_);
                     }
                     else
                     {
                        _loc11_ = new TitanChallengeBattleThread(_loc7_,_loc5_,_loc12_);
                     }
                  }
               }
               else
               {
                  _loc11_ = new ReplayTowerBattleThread(_loc7_);
               }
            }
            else
            {
               _loc11_ = new DungeonHeroBattleThread(_loc7_);
            }
         }
         else
         {
            _loc11_ = new ReplayMissionBattleThread(_loc7_);
         }
         if(_loc11_ == null && _loc8_.indexOf("boss") == 0)
         {
            _loc3_ = _loc8_.slice("boss".length + 1);
            _loc11_ = new ReplayBossBattleThread(_loc7_,DataStorage.boss.getByType(_loc3_));
         }
         _loc11_.onComplete.addOnce(onReplayCompleteListener);
         _loc11_.onRetreat.addOnce(onReplayCompleteListener);
         _loc11_.run();
      }
      
      protected function onReplayCompleteListener(param1:BattleThread) : void
      {
         Game.instance.screen.hideBattle();
         signal_replayComplete.dispatch(param1);
         signal_replayComplete.removeAll();
      }
   }
}
