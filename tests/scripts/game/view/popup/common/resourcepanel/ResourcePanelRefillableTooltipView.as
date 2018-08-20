package game.view.popup.common.resourcepanel
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelRefillableTooltipData;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.util.TimeFormatter;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.display.DisplayObjectContainer;
   
   public class ResourcePanelRefillableTooltipView extends ResourcePanelTooltipView
   {
       
      
      private var _clip:PopupResourcePanelEnergyTooltipViewClip;
      
      private var data:ResourcePanelRefillableTooltipData;
      
      private var source:ITooltipSource;
      
      public function ResourcePanelRefillableTooltipView()
      {
         super();
      }
      
      override public function show(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         this.source = param1;
         param2.addChild(this);
         data = param1.tooltipVO.hintData as ResourcePanelRefillableTooltipData;
         data.signal_updateText.add(handler_updateText);
         setText();
      }
      
      override public function hide() : void
      {
         super.hide();
         data.signal_updateText.remove(handler_updateText);
      }
      
      override protected function create() : void
      {
         _clip = AssetStorage.rsx.popup_theme.create(PopupResourcePanelEnergyTooltipViewClip,"resource_panel_tooltip_energy");
         addChild(_clip.graphics);
      }
      
      private function setText() : void
      {
         var _loc1_:ResourcePanelRefillableTooltipData = source.tooltipVO.hintData as ResourcePanelRefillableTooltipData;
         _clip.tf_text.text = _loc1_.text;
         _clip.tf_refill_time.visible = _loc1_.regenTimer != -1;
         if(_loc1_.regenTimer != -1)
         {
            _clip.tf_refill_time.text = Translate.translate("UI_TOOLTIP_ENERGY_PLUS_ONE_IN") + " " + ColorUtils.hexToRGBFormat(16383999) + TimeFormatter.toMS2(_loc1_.regenTimer,"{m}:{s}");
         }
         _clip.tf_refill_count.text = Translate.translate("UI_TOOLTIP_REFILLS_TODAY") + " " + ColorUtils.hexToRGBFormat(16383999) + _loc1_.refillsLeft + "/" + _loc1_.refillsMax;
         _clip.tf_refill_count.visible = _loc1_.refillsLeft >= 0;
         _clip.layout_main.validate();
         _clip.bg.graphics.width = _clip.layout_main.graphics.width + 28;
         _clip.bg.graphics.height = _clip.layout_main.graphics.height + 26;
         draw();
      }
      
      private function handler_updateText() : void
      {
         setText();
      }
   }
}
