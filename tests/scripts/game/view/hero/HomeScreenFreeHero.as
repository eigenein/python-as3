package game.view.hero
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.UnitDescription;
   import game.view.gui.QuestHeroAdviceValueObject;
   import game.view.gui.homescreen.HomeScreenHeroAdviceClip;
   import starling.display.DisplayObjectContainer;
   
   public class HomeScreenFreeHero extends FreeHero
   {
       
      
      private var adviceClip:HomeScreenHeroAdviceClip;
      
      private var _desc:UnitDescription;
      
      public function HomeScreenFreeHero(param1:UnitDescription)
      {
         super();
         this._desc = param1;
      }
      
      public function get desc() : UnitDescription
      {
         return _desc;
      }
      
      public function clearAdvice() : void
      {
         if(adviceClip)
         {
            adviceClip.animateHide();
         }
      }
      
      public function addAdvice(param1:QuestHeroAdviceValueObject) : void
      {
         clearAdvice();
         adviceClip = AssetStorage.rsx.popup_theme.create(HomeScreenHeroAdviceClip,"hero_advice_bubble");
         (view.statusBar.graphics as DisplayObjectContainer).addChild(adviceClip.graphics);
         adviceClip.graphics.y = -100;
         adviceClip.setData(param1);
      }
   }
}
