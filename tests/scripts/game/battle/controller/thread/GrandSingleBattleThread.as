package game.battle.controller.thread
{
   import game.assets.battle.BattlegroundAsset;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.data.storage.DataStorage;
   import game.mechanics.grand.mediator.GrandBattleThread;
   import game.model.GameModel;
   import game.model.user.sharedobject.RefreshMetadata;
   
   public class GrandSingleBattleThread extends ArenaBattleThread
   {
       
      
      private var parentThread:GrandBattleThread;
      
      public function GrandSingleBattleThread(param1:GrandBattleThread, param2:ArenaBattleResultValueObject, param3:Boolean)
      {
         super(param2.source,param3);
         this.parentThread = param1;
         commandResult = param2;
      }
      
      override protected function continueAfterRefresh(param1:ArenaBattleResultValueObject) : void
      {
         if(param1 != null && parentThread != null)
         {
            GameModel.instance.player.sharedObjectStorage.refreshMeta = RefreshMetadata.grand(parentThread.replayIds);
         }
      }
      
      override protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return AssetStorage.battleground.getById(DataStorage.rule.arenaRule.grandBattlegroundAsset);
      }
   }
}
