package game.mechanics.boss.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.hero.HeroDescription;
   import game.mechanics.boss.popup.BossRecommendedHeroesListPopup;
   import game.mechanics.boss.storage.BossTypeDescription;
   import game.mediator.gui.popup.hero.HeroListPopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class BossRecommendedHeroesListPopupMediator extends HeroListPopupMediator
   {
       
      
      private var bossType:BossTypeDescription;
      
      public function BossRecommendedHeroesListPopupMediator(param1:Player, param2:BossTypeDescription)
      {
         this.bossType = param2;
         super(param1);
      }
      
      override public function get title() : String
      {
         return Translate.translate("UI_DIALOG_BOSS_RECOMMENDED_HEROES_TITLE");
      }
      
      public function get recommendedHeroesText() : String
      {
         return bossType.recommendedHeroesText;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BossRecommendedHeroesListPopup(this);
         return _popup;
      }
      
      override protected function getHeroesList() : Vector.<HeroDescription>
      {
         return bossType.recommendedHeroes;
      }
   }
}
