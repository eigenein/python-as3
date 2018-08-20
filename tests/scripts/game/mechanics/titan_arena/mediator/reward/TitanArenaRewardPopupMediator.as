package game.mechanics.titan_arena.mediator.reward
{
   import com.progrestar.common.lang.Translate;
   import game.data.reward.RewardData;
   import game.mechanics.titan_arena.mediator.halloffame.TitanArenaHallOfFamePopupMediator;
   import game.mechanics.titan_arena.model.TitanArenaHallOfFameVO;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaHallOfFameGet;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaTrophyRewardFarm;
   import game.mechanics.titan_arena.popup.reward.TitanArenaRewardPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArenaTrophyData;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class TitanArenaRewardPopupMediator extends PopupMediator
   {
       
      
      private var _player:Player;
      
      public var signal_infoUpdate:Signal;
      
      public function TitanArenaRewardPopupMediator(param1:Player)
      {
         signal_infoUpdate = new Signal(TitanArenaHallOfFameVO);
         super(param1);
         _player = param1;
      }
      
      public function get trophyWithNotFarmedReward() : PlayerTitanArenaTrophyData
      {
         return _player.titanArenaData.trophyWithNotFarmedReward;
      }
      
      public function get serverName() : String
      {
         return player.serverId + " " + Translate.translate("LIB_SERVER_NAME_" + player.serverId);
      }
      
      public function get clanName() : String
      {
         return player.clan.clan.title;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaRewardPopup(this);
         return _popup;
      }
      
      public function action_getHallOfFameInfo() : void
      {
         var _loc1_:CommandTitanArenaHallOfFameGet = GameModel.instance.actionManager.titanArena.titanArenaHallOfFameGet();
         _loc1_.signal_complete.add(handler_hallOfFameGet);
      }
      
      public function action_farm() : void
      {
         var _loc1_:* = null;
         if(trophyWithNotFarmedReward)
         {
            _loc1_ = GameModel.instance.actionManager.titanArena.titanArenaTrophyRewardFarm(trophyWithNotFarmedReward);
            _loc1_.signal_rewardFarm.add(handler_TitanArenaTrophyRewardFarm);
            close();
         }
      }
      
      public function getClanRewardByMemberId(param1:String) : RewardData
      {
         return trophyWithNotFarmedReward.clanRewards[param1] as RewardData;
      }
      
      public function getClanRewardsCount() : int
      {
         var _loc1_:uint = 0;
         var _loc4_:int = 0;
         var _loc3_:* = trophyWithNotFarmedReward.clanRewards;
         for each(var _loc2_ in trophyWithNotFarmedReward.clanRewards)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      private function handler_hallOfFameGet(param1:CommandTitanArenaHallOfFameGet) : void
      {
         var _loc2_:TitanArenaHallOfFameVO = new TitanArenaHallOfFameVO(param1.result.body);
         signal_infoUpdate.dispatch(_loc2_);
      }
      
      private function handler_TitanArenaTrophyRewardFarm(param1:CommandTitanArenaTrophyRewardFarm) : void
      {
         param1.signal_complete.remove(handler_TitanArenaTrophyRewardFarm);
         if(trophyWithNotFarmedReward)
         {
            new TitanArenaRewardPopupMediator(_player).open(Stash.click("farm_reward",_popup.stashParams));
         }
         else
         {
            new TitanArenaHallOfFamePopupMediator(_player).open(Stash.click("farm_reward",_popup.stashParams));
         }
      }
   }
}
