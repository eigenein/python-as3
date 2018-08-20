package game.mediator.gui.popup.clan
{
   import feathers.data.ListCollection;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxClanIconsAsset;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.clan.editicon.ClanEditIconCanvasValueObject;
   import game.mediator.gui.popup.clan.editicon.ClanEditIconColorValueObject;
   import game.mediator.gui.popup.clan.editicon.ClanEditIconEmblemValueObject;
   import game.mediator.gui.popup.clan.editicon.ClanEditIconValueObject;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.clan.editicon.ClanEditIconPopup;
   import org.osflash.signals.Signal;
   import starling.textures.Texture;
   
   public class ClanEditIconPopupMediator extends ClanPopupMediatorBase
   {
       
      
      private const asset:RsxClanIconsAsset = AssetStorage.rsx.clan_icons;
      
      private var _color1:ClanEditIconColorValueObject;
      
      private var _color2:ClanEditIconColorValueObject;
      
      private var _color3:ClanEditIconColorValueObject;
      
      private var _canvas:ClanEditIconCanvasValueObject;
      
      private var _emblem:ClanEditIconEmblemValueObject;
      
      private var _showCost:Boolean;
      
      public const colorsDataProvider:ListCollection = new ListCollection();
      
      public const canvasDataProvider:ListCollection = new ListCollection();
      
      public const emblemDataProvider:ListCollection = new ListCollection();
      
      public const cost:InventoryItem = DataStorage.rule.clanRule.changeIconCost.outputDisplay[0];
      
      public const signal_complete:Signal = new Signal(ClanIconValueObject);
      
      public const signal_costUpdated:Signal = new Signal();
      
      public const signal_canvasUpdated:Signal = new Signal();
      
      public const signal_emblemUpdated:Signal = new Signal();
      
      public function ClanEditIconPopupMediator(param1:Player, param2:ClanIconValueObject, param3:Boolean = true)
      {
         super(param1);
         colorsDataProvider.data = createColors();
         canvasDataProvider.data = createCanvases();
         emblemDataProvider.data = createEmblems();
         _color1 = getItemById(param2.flagColor1,colorsDataProvider) as ClanEditIconColorValueObject;
         _color2 = getItemById(param2.flagColor2,colorsDataProvider) as ClanEditIconColorValueObject;
         _color3 = getItemById(param2.iconColor,colorsDataProvider) as ClanEditIconColorValueObject;
         _canvas = getItemById(param2.flagShape,canvasDataProvider) as ClanEditIconCanvasValueObject;
         _emblem = getItemById(param2.iconShape,emblemDataProvider) as ClanEditIconEmblemValueObject;
         _showCost = param3;
      }
      
      private function getItemById(param1:int, param2:ListCollection) : ClanEditIconValueObject
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get color1() : ClanEditIconColorValueObject
      {
         return _color1;
      }
      
      public function get color2() : ClanEditIconColorValueObject
      {
         return _color2;
      }
      
      public function get color3() : ClanEditIconColorValueObject
      {
         return _color3;
      }
      
      public function get canvas() : ClanEditIconCanvasValueObject
      {
         return _canvas;
      }
      
      public function get emblem() : ClanEditIconEmblemValueObject
      {
         return _emblem;
      }
      
      public function get showCost() : Boolean
      {
         return _showCost;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney();
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanEditIconPopup(this);
         return new ClanEditIconPopup(this);
      }
      
      public function action_save() : void
      {
         var _loc1_:ClanIconValueObject = new ClanIconValueObject();
         var _loc4_:int = _color1.id;
         var _loc3_:int = _color2.id;
         var _loc2_:int = _canvas.id;
         var _loc5_:int = _color3.id;
         var _loc6_:int = _emblem.id;
         _loc1_.setup(_loc4_,_loc3_,_loc2_,_loc5_,_loc6_);
         close();
         signal_complete.dispatch(_loc1_);
      }
      
      public function action_selectColor1(param1:ClanEditIconColorValueObject) : void
      {
         _color1 = param1;
         signal_canvasUpdated.dispatch();
      }
      
      public function action_selectColor2(param1:ClanEditIconColorValueObject) : void
      {
         _color2 = param1;
         signal_canvasUpdated.dispatch();
      }
      
      public function action_selectColor3(param1:ClanEditIconColorValueObject) : void
      {
         _color3 = param1;
         signal_emblemUpdated.dispatch();
      }
      
      public function action_selectCanvas(param1:ClanEditIconCanvasValueObject) : void
      {
         _canvas = param1;
         signal_canvasUpdated.dispatch();
      }
      
      public function action_selectEmblem(param1:ClanEditIconEmblemValueObject) : void
      {
         _emblem = param1;
         signal_emblemUpdated.dispatch();
      }
      
      protected function createColors() : Vector.<ClanEditIconColorValueObject>
      {
         var _loc3_:Vector.<ClanEditIconColorValueObject> = new Vector.<ClanEditIconColorValueObject>();
         var _loc1_:Vector.<int> = DataStorage.clanIcon.colorIds;
         var _loc5_:int = 0;
         var _loc4_:* = _loc1_;
         for each(var _loc2_ in _loc1_)
         {
            _loc3_.push(new ClanEditIconColorValueObject(_loc2_,asset.getColor(_loc2_)));
         }
         return _loc3_;
      }
      
      protected function createCanvases() : Vector.<ClanEditIconCanvasValueObject>
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc5_:Vector.<ClanEditIconCanvasValueObject> = new Vector.<ClanEditIconCanvasValueObject>();
         var _loc3_:Vector.<int> = DataStorage.clanIcon.flagShapeIds;
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc1_ = asset.getFlagColorPatternTexture(_loc4_);
            _loc2_ = asset.getIconColorPatternTexture(_loc4_);
            _loc5_.push(new ClanEditIconCanvasValueObject(_loc4_,this,_loc1_,_loc2_));
         }
         return _loc5_;
      }
      
      protected function createEmblems() : Vector.<ClanEditIconEmblemValueObject>
      {
         var _loc3_:Vector.<ClanEditIconEmblemValueObject> = new Vector.<ClanEditIconEmblemValueObject>();
         var _loc1_:Vector.<int> = DataStorage.clanIcon.iconShapeIds;
         var _loc5_:int = 0;
         var _loc4_:* = _loc1_;
         for each(var _loc2_ in _loc1_)
         {
            _loc3_.push(new ClanEditIconEmblemValueObject(_loc2_,this,asset.getIconTexture(_loc2_)));
         }
         return _loc3_;
      }
   }
}
