package game.view.popup.test.stattask
{
   import engine.core.utils.property.StringProperty;
   import flash.desktop.Clipboard;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class BattleStatTaskPopupMediator extends PopupMediator
   {
       
      
      private var e:BattleStatTaskExecutor;
      
      public function BattleStatTaskPopupMediator(param1:Player, param2:BattleStatTaskExecutor)
      {
         super(param1);
         this.e = param2;
      }
      
      public function get progressReport() : StringProperty
      {
         return e.progressReport;
      }
      
      public function get resultReport() : StringProperty
      {
         return e.resultReport;
      }
      
      public function action_start(param1:String) : void
      {
         e.execute(param1);
      }
      
      public function action_copy() : void
      {
         Clipboard.generalClipboard.setData("air:text",e.resultReport.value);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BattleStatTaskPopup(this);
         return new BattleStatTaskPopup(this);
      }
   }
}
