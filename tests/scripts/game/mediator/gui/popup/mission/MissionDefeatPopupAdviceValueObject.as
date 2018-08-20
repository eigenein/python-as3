package game.mediator.gui.popup.mission
{
   import game.view.popup.fightresult.pve.defeatpopuprenderers.ImprovementRenderer;
   
   public class MissionDefeatPopupAdviceValueObject
   {
       
      
      private var _action:Function;
      
      private var _renderer:ImprovementRenderer;
      
      public function MissionDefeatPopupAdviceValueObject(param1:Function, param2:ImprovementRenderer)
      {
         super();
         this._renderer = param2;
         this._action = param1;
      }
      
      public function get action() : Function
      {
         return _action;
      }
      
      public function get renderer() : ImprovementRenderer
      {
         return _renderer;
      }
   }
}
