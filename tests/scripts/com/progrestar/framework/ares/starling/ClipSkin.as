package com.progrestar.framework.ares.starling
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.core.Container;
   import com.progrestar.framework.ares.core.Frame;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.core.State;
   import com.progrestar.framework.ares.events.ClipEventTimeline;
   import com.progrestar.framework.ares.events.IClipEvent;
   import com.progrestar.framework.ares.extension.sounds.ClipSoundEvent;
   import com.progrestar.framework.ares.extension.sounds.IClipSoundEventHandler;
   import com.progrestar.framework.ares.utils.ClipUtils;
   import flash.utils.Dictionary;
   import starling.display.DisplayObject;
   
   public class ClipSkin
   {
       
      
      public var clip:Clip;
      
      private var _events:ClipEventTimeline;
      
      private var _soundHandler:IClipSoundEventHandler;
      
      private var skinPartMapping:Dictionary;
      
      private var slotNodeMapping:Dictionary;
      
      private var displayObjectMapping:Dictionary;
      
      private var updateDisplayObjectMapping:Dictionary;
      
      private var clipAssetDataProvider:ClipAssetDataProvider;
      
      public function ClipSkin(param1:Clip, param2:ClipAssetDataProvider = null)
      {
         skinPartMapping = new Dictionary();
         displayObjectMapping = new Dictionary();
         updateDisplayObjectMapping = new Dictionary();
         super();
         this.clip = param1;
         this.clipAssetDataProvider = param2;
      }
      
      public function get events() : ClipEventTimeline
      {
         return _events;
      }
      
      public function useSoundsFromAsset(param1:ClipAsset, param2:IClipSoundEventHandler) : void
      {
         _soundHandler = param2;
      }
      
      public function setClip(param1:Clip) : void
      {
         this.clip = param1;
         var _loc2_:Dictionary = new Dictionary();
         var _loc5_:int = 0;
         var _loc4_:* = skinPartMapping;
         for(var _loc3_ in skinPartMapping)
         {
            _loc2_[_loc3_] = skinPartMapping[_loc3_];
         }
         skinPartMapping = _loc2_;
      }
      
      public function applySkinPart(param1:String, param2:*) : void
      {
         skinPartMapping[param1] = param2;
      }
      
      public function getSkinPart(param1:Clip) : *
      {
         return skinPartMapping[param1.className];
      }
      
      public function getMarkerDisplayObject(param1:String) : DisplayObject
      {
         return displayObjectMapping[param1];
      }
      
      public function getUpdatedMarkerDisplayObject(param1:String) : DisplayObject
      {
         if(updateDisplayObjectMapping[param1])
         {
            return displayObjectMapping[param1];
         }
         return null;
      }
      
      public function getMarkerState(param1:uint, param2:String) : State
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getFrameTexture(param1:Frame) : ClipFrame
      {
         var _loc2_:* = undefined;
         if(clipAssetDataProvider != null)
         {
            return clipAssetDataProvider.getClipFrame(param1.id);
         }
         _loc2_ = ClipImageCache.getImageTextures(param1.image);
         return _loc2_[param1.id];
      }
      
      public function dropPreviousMarkers() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = updateDisplayObjectMapping;
         for(var _loc1_ in updateDisplayObjectMapping)
         {
            updateDisplayObjectMapping[_loc1_] = false;
         }
      }
      
      public function playSoundFromEvent(param1:IClipEvent) : void
      {
         if(_soundHandler != null && param1 is ClipSoundEvent)
         {
            _soundHandler.onSoundEvent(param1 as ClipSoundEvent);
         }
      }
      
      function setMarkerDisplayObject(param1:String, param2:DisplayObject) : void
      {
         displayObjectMapping[param1] = param2;
         updateDisplayObjectMapping[param1] = true;
      }
      
      private function createSlotClipMapping() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
