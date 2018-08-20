package game.mediator.gui.popup.team
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class ArenaDefenderTeamGatherPopupMediator extends TeamGatherPopupMediator
   {
       
      
      private var activity:MechanicDescription;
      
      private var blockReason:TeamGatherHeroBlockReason;
      
      public function ArenaDefenderTeamGatherPopupMediator(param1:Player, param2:Vector.<HeroDescription>)
      {
         activity = MechanicStorage.ARENA;
         blockReason = new TeamGatherHeroBlockReason(Translate.translateArgs("UI_DIALOG_TEAM_GATHER_LEVEL_NEEDED",activity.minHeroLevel));
         super(param1,UnitUtils.heroVectorToUnitVector(param2));
      }
      
      override public function action_pick(param1:TeamGatherPopupHeroValueObject, param2:Number = 0.2) : void
      {
         if(param1 == null || !param1.isAvailable)
         {
            return;
         }
         if(param1.level < activity.minHeroLevel)
         {
            PopupList.instance.message(blockReason.text);
            return;
         }
         super.action_pick(param1,param2);
      }
      
      override public function createPopup() : PopupBase
      {
         var _loc1_:PopupBase = super.createPopup();
         _loc1_.stashParams.windowName = "team_gather:arena_defense";
         return _loc1_;
      }
      
      override public function get startButtonLabel() : String
      {
         return Translate.translate("UI_DIALOG_ARENA_DEFENDER_TEAM_GATHER_START");
      }
      
      override public function isHeroUnavailable(param1:TeamGatherPopupHeroValueObject) : TeamGatherHeroBlockReason
      {
         if(param1.isAvailable && param1.level >= activity.minHeroLevel)
         {
            return null;
         }
         return blockReason;
      }
   }
}
