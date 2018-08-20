package game.view.popup.activity
{
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.controller.IButtonView;
   import game.view.gui.components.controller.TouchButtonController;
   import game.view.gui.components.list.ListItemRenderer;
   import starling.filters.ColorMatrixFilter;
   import starling.filters.FragmentFilter;
   
   public class ChainQuestsListRenderer extends ListItemRenderer implements IButtonView
   {
       
      
      private var mediator:ChainQuestsListRendererMediator;
      
      private var clip:ChainQuestsListRendererClip;
      
      private var touchController:TouchButtonController;
      
      private var containerFilter:FragmentFilter;
      
      public function ChainQuestsListRenderer()
      {
         super();
         useHandCursor = true;
         mediator = new ChainQuestsListRendererMediator();
         mediator.signalUpdate.add(onQuestsUpdate);
      }
      
      override public function dispose() : void
      {
         mediator.signalUpdate.remove(onQuestsUpdate);
         mediator.dispose();
         touchController.dispose();
         super.dispose();
      }
      
      override public function set data(param1:Object) : void
      {
         .super.data = param1;
         if(mediator.chainElement == data)
         {
            return;
         }
         mediator.chainElement = data as SpecialQuestEventChainTabValueObject;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid("selected"))
         {
            if(clip)
            {
               _loc1_ = this.isSelected;
               clip.bg_selected.graphics.visible = _loc1_;
               var _loc2_:* = !_loc1_;
               clip.tf_text.includeInLayout = _loc2_;
               clip.tf_text.visible = _loc2_;
               _loc2_ = _loc1_;
               clip.tf_text_selected.includeInLayout = _loc2_;
               clip.tf_text_selected.visible = _loc2_;
            }
         }
      }
      
      public function click() : void
      {
         isSelected = true;
      }
      
      public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(param1 == "hover")
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(0.1);
            containerFilter = clip.container.filter;
            clip.container.filter = _loc3_;
         }
         else
         {
            if(clip.container.filter)
            {
               clip.container.filter.dispose();
            }
            clip.container.filter = containerFilter;
            containerFilter = null;
         }
      }
      
      override protected function initialize() : void
      {
         clip = AssetStorage.rsx.popup_theme.create_chain_quests_list_renderer();
         addChild(clip.graphics);
         touchController = new TouchButtonController(clip.container,this);
      }
      
      override protected function commitData() : void
      {
         if(mediator.chainElement)
         {
            onQuestsUpdate();
            clip.tf_text.text = mediator.chainName;
            clip.tf_text_selected.text = mediator.chainName;
         }
      }
      
      private function onQuestsUpdate() : void
      {
         clip.animation_highlight.graphics.visible = mediator.notFarmQuestsAvaliable();
      }
   }
}
