package game.view.popup.artifacts
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.artifacts.PlayerTitanWithArtifactsVO;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.hero.minilist.HeroPopupMiniHeroListItem;
   import game.view.popup.hero.minilist.HeroPopupMiniHeroListItemClip;
   
   public class HeroArtifactsMiniHeroListItem extends HeroPopupMiniHeroListItem
   {
       
      
      public function HeroArtifactsMiniHeroListItem()
      {
         super();
      }
      
      override public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:* = null;
         var _loc3_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         if(data is PlayerTitanWithArtifactsVO)
         {
            _loc3_.addButtonWithKey(TutorialNavigator.TITAN_ARTIFACT,clip,(data as PlayerTitanWithArtifactsVO).titan);
         }
         else
         {
            _loc2_ = data as PlayerHeroListValueObject;
         }
         return _loc3_;
      }
      
      override protected function createClip() : HeroPopupMiniHeroListItemClip
      {
         return AssetStorage.rsx.popup_theme.create(HeroArtifactsMiniHeroListItemClip,"hero_dialog_mini_hero");
      }
   }
}
