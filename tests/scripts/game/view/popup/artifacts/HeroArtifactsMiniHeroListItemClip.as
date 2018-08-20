package game.view.popup.artifacts
{
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.view.popup.hero.minilist.HeroPopupMiniHeroListItemClip;
   
   public class HeroArtifactsMiniHeroListItemClip extends HeroPopupMiniHeroListItemClip
   {
       
      
      public function HeroArtifactsMiniHeroListItemClip()
      {
         super();
      }
      
      override protected function addListeners(param1:PlayerHeroListValueObject) : void
      {
         super.addListeners(param1);
         if(param1)
         {
            param1.signal_updateArtifactUpgradeAvaliable.add(handler_redDotStateChange);
         }
      }
      
      override protected function removeListeners(param1:PlayerHeroListValueObject) : void
      {
         super.removeListeners(param1);
         if(param1)
         {
            param1.signal_updateArtifactUpgradeAvaliable.remove(handler_redDotStateChange);
         }
      }
   }
}
