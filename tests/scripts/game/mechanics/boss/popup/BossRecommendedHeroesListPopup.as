package game.mechanics.boss.popup
{
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.boss.mediator.BossRecommendedHeroesListPopupMediator;
   import game.mediator.gui.popup.hero.HeroListPopupMediator;
   import game.view.popup.hero.HeroListDialogBaseClip;
   import game.view.popup.hero.HeroListPopup;
   
   public class BossRecommendedHeroesListPopup extends HeroListPopup
   {
       
      
      public function BossRecommendedHeroesListPopup(param1:HeroListPopupMediator)
      {
         super(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:TiledRowsLayout = list.layout as TiledRowsLayout;
         _loc1_.paddingTop = 6;
         _loc1_.paddingBottom = 24;
         (asset as HeroListDialogBossRecommendedHeroesClip).tf_caption.text = (mediator as BossRecommendedHeroesListPopupMediator).recommendedHeroesText;
      }
      
      override protected function createClip() : HeroListDialogBaseClip
      {
         return AssetStorage.rsx.dialog_boss.create(HeroListDialogBossRecommendedHeroesClip,"dialog_boss_recommended_heroes_list");
      }
   }
}
