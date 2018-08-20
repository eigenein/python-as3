package game.mechanics.grand.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.team.MultiTeamGatherPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherHeroBlockReason;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.team.GrandDefendersTeamGatherPopup;
   
   public class GrandDefendersTeamGatherPopupMedaitor extends MultiTeamGatherPopupMediator
   {
       
      
      protected var activity:MechanicDescription;
      
      protected var blockReason:TeamGatherHeroBlockReason;
      
      public function GrandDefendersTeamGatherPopupMedaitor(param1:Player, param2:Vector.<Vector.<UnitDescription>>)
      {
         activity = MechanicStorage.GRAND;
         filterMultiTeamHeroesByTeamLevel(param1,param2,activity.minHeroLevel);
         blockReason = new TeamGatherHeroBlockReason(Translate.translateArgs("UI_DIALOG_TEAM_GATHER_LEVEL_NEEDED",activity.minHeroLevel));
         super(param1,param2);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new GrandDefendersTeamGatherPopup(this);
         return _popup;
      }
      
      override public function isHeroUnavailable(param1:TeamGatherPopupHeroValueObject) : TeamGatherHeroBlockReason
      {
         if(!param1.isEmpty && param1.level >= activity.minHeroLevel)
         {
            return null;
         }
         return blockReason;
      }
   }
}
