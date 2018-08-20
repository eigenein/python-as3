package game.command.intern
{
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skin.SkinDescription;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.hero.HeroPopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class OpenHeroPopUpCommand implements IInternalCommand
   {
       
      
      private var hero:HeroDescription;
      
      private var stashParams:PopupStashEventParams;
      
      private var player:Player;
      
      public var selectedTab:String = "TAB_SKILLS";
      
      public var selectedSkin:SkinDescription;
      
      public var recieveInfoMode:Boolean = true;
      
      public var closeAllPopups:Boolean = false;
      
      public function OpenHeroPopUpCommand(param1:Player, param2:HeroDescription, param3:PopupStashEventParams)
      {
         super();
         this.player = param1;
         this.hero = param2;
         this.stashParams = param3;
      }
      
      public function execute() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(player && hero)
         {
            _loc1_ = player.heroes.getById(hero.id);
            if(_loc1_)
            {
               if(closeAllPopups)
               {
                  GamePopupManager.closeAll();
               }
               _loc2_ = PopupList.instance.dialog_hero(hero,selectedTab);
               if(selectedSkin)
               {
                  _loc2_.signal_skinBrowse.dispatch(selectedSkin);
               }
            }
            else
            {
               PopupList.instance.dialog_hero_description(hero,recieveInfoMode,stashParams);
            }
         }
      }
   }
}
