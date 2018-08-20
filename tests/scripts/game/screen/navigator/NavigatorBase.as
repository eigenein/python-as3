package game.screen.navigator
{
   import com.progrestar.common.Logger;
   import com.progrestar.common.lang.Translate;
   import game.data.storage.level.LevelRequirement;
   import game.mediator.gui.popup.PopupList;
   import game.model.user.Player;
   
   public class NavigatorBase
   {
       
      
      public const logger:Logger = Logger.getLogger(NavigatorBase);
      
      protected var navigator:GameNavigator;
      
      protected var player:Player;
      
      public function NavigatorBase(param1:GameNavigator, param2:Player)
      {
         super();
         this.player = param2;
         this.navigator = param1;
      }
      
      protected function checkTeamLevel(param1:LevelRequirement) : Boolean
      {
         if(player.levelData.level.level < param1.teamLevel)
         {
            PopupList.instance.message(Translate.translateArgs("UI_MECHANIC_NAVIGATOR_TEAM_LEVEL_REQUIRED",param1.teamLevel));
            return false;
         }
         return true;
      }
   }
}
