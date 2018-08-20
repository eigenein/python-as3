package game.view.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.VerticalLayout;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.HeroPopupMediator;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipList;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.hero.slot.ClipListItemBattleStat;
   
   public class HeroPopupStatList extends GuiClipNestedContainer
   {
       
      
      private var scrollContainer:GameScrollContainer;
      
      private var statItems:Vector.<HeroPopupStatListItemRenderer>;
      
      public var header_block:HeroPopupStatListInfoBlock;
      
      public var stats_list:ClipList;
      
      public var stats_item:ClipDataProvider;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      private var _mediator:HeroPopupMediator;
      
      public function HeroPopupStatList()
      {
         statItems = new Vector.<HeroPopupStatListItemRenderer>();
         header_block = new HeroPopupStatListInfoBlock();
         stats_list = new ClipList(ClipListItemBattleStat);
         stats_item = stats_list.itemClipProvider;
         gradient_bottom = new ClipSpriteUntouchable();
         gradient_top = new ClipSpriteUntouchable();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc3_:int = 5;
         var _loc2_:GameScrollBar = new GameScrollBar();
         _loc2_.height = scroll_slider_container.container.height;
         scroll_slider_container.container.addChild(_loc2_);
         var _loc4_:VerticalLayout = new VerticalLayout();
         var _loc5_:int = 20;
         _loc4_.paddingBottom = _loc5_;
         _loc4_.paddingTop = _loc5_;
         _loc4_.gap = 5;
         scrollContainer = new GameScrollContainer(_loc2_,gradient_top.graphics,gradient_bottom.graphics);
         scrollContainer.layout = _loc4_;
         scrollContainer.width = list_container.container.width;
         scrollContainer.height = list_container.container.height;
         scrollContainer.addChild(header_block.layout_main);
         list_container.container.addChild(scrollContainer);
      }
      
      public function set mediator(param1:HeroPopupMediator) : void
      {
         _mediator = param1;
         _mediator.signal_statsUpdate.add(handler_statListUpdate);
      }
      
      public function updateStats() : void
      {
         updateList();
         header_block.setData(_mediator.hero.hero);
         header_block.tf_label_stats.text = Translate.translate("UI_DIALOG_HERO_STAT_LIST_HEADER");
      }
      
      private function updateList() : void
      {
         var _loc1_:* = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = statItems.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc1_ = statItems[_loc6_];
            TooltipHelper.removeTooltip(_loc1_);
            scrollContainer.removeChild(_loc1_,true);
            _loc6_++;
         }
         statItems = new Vector.<HeroPopupStatListItemRenderer>();
         var _loc3_:HeroPopupStatListTooltipFactory = new HeroPopupStatListTooltipFactory();
         _loc2_ = _mediator.statList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = new HeroPopupStatListItemRenderer();
            _loc5_ = _mediator.statList.getItemAt(_loc4_) as BattleStatValueObject;
            _loc1_.data = _loc5_;
            if(_loc3_.hasTooltip(_loc5_))
            {
               TooltipHelper.addTooltip(_loc1_,_loc3_.createTooltip(_loc5_));
            }
            scrollContainer.addChild(_loc1_);
            statItems.push(_loc1_);
            _loc4_++;
         }
      }
      
      private function handler_statListUpdate(param1:Vector.<BattleStatValueObject>) : void
      {
         updateList();
      }
   }
}
