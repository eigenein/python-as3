package game.util
{
   import com.progrestar.common.util.ExternalInterfaceProxy;
   import feathers.core.PopUpManager;
   import flash.utils.Dictionary;
   import game.command.rpc.mission.CommandBattleStartReplay;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.model.GameModel;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.HeroEntrySourceData;
   import game.view.popup.hero.upgrade.HeroColorUpPopup;
   import game.view.popup.test.BattleTestStatsPopupMediator;
   
   public class ConsoleCommandsJS
   {
       
      
      public function ConsoleCommandsJS()
      {
         super();
      }
      
      public function init() : void
      {
         var _loc2_:Dictionary = new Dictionary();
         if(ExternalInterfaceProxy.available)
         {
            _loc2_["replayMission"] = replayMission;
            _loc2_["replayArena"] = replayMission;
            _loc2_["testDialog_heroColorUp"] = testDialog_heroColorUp;
            _loc2_["testBalance"] = testBalance;
            var _loc4_:int = 0;
            var _loc3_:* = _loc2_;
            for(var _loc1_ in _loc2_)
            {
               ExternalInterfaceProxy.addCallback("jsc_" + _loc1_,_loc2_[_loc1_]);
            }
         }
      }
      
      [Console(text="Автоматическое проведение боёв и сбор статистики для баланса персонажей")]
      public function testBalance() : void
      {
         var _loc1_:* = null;
         if(GameModel.instance.player.flags.getFlag(2))
         {
            _loc1_ = new BattleTestStatsPopupMediator(GameModel.instance.player);
            _loc1_.open();
         }
      }
      
      public function replayMission(param1:String) : void
      {
         var _loc2_:CommandBattleStartReplay = new CommandBattleStartReplay(param1);
         GameModel.instance.actionManager.executeRPCCommand(_loc2_);
      }
      
      public function replayArena(param1:String) : void
      {
         var _loc2_:CommandBattleStartReplay = new CommandBattleStartReplay(param1);
         GameModel.instance.actionManager.executeRPCCommand(_loc2_);
      }
      
      public function testDialog_heroColorUp(param1:int, param2:int, param3:int = 2) : void
      {
         var _loc5_:HeroDescription = DataStorage.hero.getHeroById(param1);
         var _loc6_:HeroEntry = new HeroEntry(_loc5_,new HeroEntrySourceData({
            "star":param2,
            "color":param3,
            "lvl":22
         }));
         var _loc4_:HeroColorUpPopup = new HeroColorUpPopup(_loc6_,1);
         PopUpManager.addPopUp(_loc4_);
      }
   }
}
