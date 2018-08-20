package game.battle.gui
{
   import com.progrestar.common.lang.Translate;
   import starling.filters.ColorMatrixFilter;
   
   public class BattleGuiSpeedUpButton extends BattleGuiToggleButton
   {
       
      
      private var _speedUpIsAvailable:Boolean = false;
      
      private var _speedUpText:String;
      
      private var _selectionText:String;
      
      public function BattleGuiSpeedUpButton()
      {
         _speedUpText = Translate.translate("UI_POPUP_BATTLE_FAST");
         _selectionText = Translate.translate("UI_POPUP_BATTLE_FAST_INFO");
         super();
      }
      
      public function set speedUpIsAvailblele(param1:Boolean) : void
      {
         _speedUpIsAvailable = param1;
         if(!param1 && isSelected)
         {
            setIsSelectedSilently(false);
         }
         _updateViewState(false);
      }
      
      override public function initialize(param1:String, param2:Function, param3:Boolean) : void
      {
         super.initialize(param1,param2,param3);
         _updateViewState(false);
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = param1 == "hover";
         if(isInHover != _loc3_)
         {
            isInHover = _loc3_;
            if(isInHover)
            {
               if(true || !hoverFilter)
               {
                  if(hoverFilter)
                  {
                     hoverFilter.dispose();
                  }
                  hoverFilter = new ColorMatrixFilter();
                  hoverFilter.adjustBrightness(0.1);
               }
               if(_container.filter != hoverFilter)
               {
                  if(defaultFilter != _container.filter)
                  {
                     if(defaultFilter)
                     {
                        defaultFilter.dispose();
                     }
                     defaultFilter = _container.filter;
                  }
                  _container.filter = hoverFilter;
               }
            }
            else
            {
               _container.filter = defaultFilter;
            }
            _updateViewState(isInHover);
         }
         if(param2 && param1 == "down")
         {
            playClickSound();
         }
      }
      
      private function _updateViewState(param1:Boolean) : void
      {
         graphics.alpha = !!_speedUpIsAvailable?1:Number(!!param1?0.8:0.4);
         label.text = param1 && !_speedUpIsAvailable?_selectionText:_speedUpText;
      }
   }
}
