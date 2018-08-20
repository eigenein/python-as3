package game.model.user.hero
{
   import battle.BattleStats;
   import game.data.storage.DataStorage;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.skin.SkinDescriptionLevel;
   
   public class PlayerHeroSkinData
   {
       
      
      public const stats:BattleStats = new BattleStats();
      
      private var skins:Object;
      
      public function PlayerHeroSkinData(param1:Object)
      {
         super();
         skins = param1 != null?param1:{};
         updateStats();
      }
      
      public function getSkinLevelByID(param1:uint) : uint
      {
         if(skins && skins.hasOwnProperty(param1))
         {
            return skins[param1];
         }
         return 0;
      }
      
      public function upgrageSkin(param1:SkinDescription, param2:uint) : void
      {
         if(!skins)
         {
            return;
         }
         if(param1)
         {
            if(skins.hasOwnProperty(param1.id))
            {
               skins[param1.id] = Math.min(skins[param1.id] + param2,param1.maxLevel);
            }
            else
            {
               skins[param1.id] = param2;
            }
            updateStats();
         }
      }
      
      private function updateStats() : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = null;
         stats.nullify();
         var _loc5_:int = 0;
         var _loc4_:* = skins;
         for(var _loc1_ in skins)
         {
            _loc2_ = uint(skins[_loc1_]);
            if(_loc2_ > 0)
            {
               _loc3_ = DataStorage.skin.getSkinById(_loc1_).levels[_loc2_ - 1];
               if(_loc3_ && _loc3_.statBonus)
               {
                  stats[_loc3_.statBonus.ident] = stats[_loc3_.statBonus.ident] + _loc3_.statBonus.statValue;
               }
            }
         }
      }
   }
}
