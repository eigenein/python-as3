package game.view.popup.summoningcircle.portrait
{
   import game.data.storage.titan.TitanDescription;
   import game.view.gui.components.controller.IButtonView;
   import game.view.gui.components.controller.TouchButtonController;
   import idv.cjcat.signals.Signal;
   import starling.filters.ColorMatrixFilter;
   import starling.filters.FragmentFilter;
   
   public class TitanPortraitButton extends TitanPortrait implements IButtonView
   {
       
      
      protected var controller:TouchButtonController;
      
      protected var containerFilter:FragmentFilter;
      
      protected var _signal_click:Signal;
      
      public function TitanPortraitButton()
      {
         _signal_click = new Signal(TitanDescription);
         super();
         controller = new TouchButtonController(this,this);
         useHandCursor = true;
      }
      
      public function get signal_click() : Signal
      {
         return _signal_click;
      }
      
      public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(param1 == "hover")
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(0.1);
            containerFilter = filter;
            filter = _loc3_;
         }
         else
         {
            if(filter)
            {
               filter.dispose();
            }
            filter = containerFilter;
            containerFilter = null;
         }
         if(param2 && param1 == "down")
         {
            Game.instance.soundPlayer.playDefaultClickSound();
         }
      }
      
      public function click() : void
      {
         _signal_click.dispatch(data.unit as TitanDescription);
      }
   }
}
