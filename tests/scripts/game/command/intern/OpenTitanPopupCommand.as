package game.command.intern
{
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.titan.PlayerTitanListValueObject;
   import game.mediator.gui.popup.titan.TitanDescriptionPopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.UnitEntry;
   
   public class OpenTitanPopupCommand implements IInternalCommand
   {
       
      
      private var player:Player;
      
      private var titan:TitanDescription;
      
      private var stashParams:PopupStashEventParams;
      
      public var closeAllPopups:Boolean = false;
      
      public function OpenTitanPopupCommand(param1:Player, param2:TitanDescription, param3:PopupStashEventParams)
      {
         super();
         this.stashParams = param3;
         this.titan = param2;
         this.player = param1;
      }
      
      public function execute() : void
      {
         var _loc1_:* = null;
         if(player && titan)
         {
            _loc1_ = UnitUtils.getPlayerUnitEntry(player,titan);
            if(_loc1_)
            {
               if(closeAllPopups)
               {
                  GamePopupManager.closeAll();
               }
               PopupList.instance.dialog_titan(titan);
            }
            else
            {
               new TitanDescriptionPopupMediator(player,new PlayerTitanListValueObject(titan,player)).open(stashParams);
            }
         }
      }
   }
}
