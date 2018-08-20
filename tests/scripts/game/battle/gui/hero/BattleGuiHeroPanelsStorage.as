package game.battle.gui.hero
{
   import battle.data.BattleHeroDescription;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.hero.BattleHeroControllerWithPanel;
   
   public class BattleGuiHeroPanelsStorage
   {
       
      
      private var panelByHero:Dictionary;
      
      public function BattleGuiHeroPanelsStorage()
      {
         panelByHero = new Dictionary();
         super();
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = panelByHero;
         for each(var _loc1_ in panelByHero)
         {
            _loc1_.dispose();
         }
         panelByHero = null;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = panelByHero;
         for each(var _loc2_ in panelByHero)
         {
            _loc2_.enabled = param1;
         }
      }
      
      public function getPanelByHero(param1:BattleHeroControllerWithPanel) : BattleHeroPanelClip
      {
         var _loc3_:* = null;
         var _loc2_:BattleHeroDescription = param1.hero.desc;
         if(panelByHero[_loc2_])
         {
            _loc3_ = panelByHero[_loc2_];
         }
         else
         {
            _loc3_ = AssetStorage.rsx.battle_interface.create(BattleHeroPanelClip,"hero_portrait_small");
            panelByHero[_loc2_] = _loc3_;
         }
         _loc3_.data = param1;
         return _loc3_;
      }
   }
}
