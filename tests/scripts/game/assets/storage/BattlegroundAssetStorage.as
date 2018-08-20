package game.assets.storage
{
   import engine.core.assets.RequestableAsset;
   import game.assets.battle.BattlegroundAsset;
   
   public class BattlegroundAssetStorage extends AssetTypeStorage
   {
       
      
      public function BattlegroundAssetStorage(param1:* = null)
      {
         super(param1);
      }
      
      public function get defaultAsset() : BattlegroundAsset
      {
         return getById(1);
      }
      
      public function getById(param1:int) : BattlegroundAsset
      {
         return dict[param1] as BattlegroundAsset;
      }
      
      override protected function createEntry(param1:String, param2:*) : RequestableAsset
      {
         var _loc3_:* = new BattlegroundAsset(param2);
         dict[param1] = _loc3_;
         return _loc3_;
      }
   }
}
