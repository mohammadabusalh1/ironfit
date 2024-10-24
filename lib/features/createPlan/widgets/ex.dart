String jsonString = '''
  [
    {
      "Exercise_Name": "Rickshaw Carry",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/742/Male/m/742_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/742/Male/m/742_2.jpg"
    },
    {
      "Exercise_Name": "Single-Leg Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50m-single-leg-leg-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50m-single-leg-leg-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Landmine twist",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-129s-landmine-twist-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-129s-landmine-twist-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Weighted pull-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-96c-weighted-pull-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-96c-weighted-pull-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "T-Bar Row with Handle",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/1931/Male/m/1931_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/october/1931_2sm.jpg"
    },
    {
      "Exercise_Name": "Palms-down wrist curl over bench",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62e-palms-down-wrist-curl-over-bench-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62e-palms-down-wrist-curl-over-bench-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Atlas Stones",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/659/Male/m/659_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/659/Male/m/659_2.jpg"
    },
    {
      "Exercise_Name": "Dumbbell front raise to lateral raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-61d-dumbbell-front-raise-to-lateral-raise-m2-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-61d-dumbbell-front-raise-to-lateral-raise-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Incline Hammer Curls",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/882/Male/m/882_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/882/Male/m/882_2.jpg"
    },
    {
      "Exercise_Name": "Straight-bar wrist roll-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-116s-straight-bar-wrist-roll-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-116s-straight-bar-wrist-roll-up-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell glute bridge",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-114s-barbell-glute-bridge-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-114s-barbell-glute-bridge-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Clean and press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-27b-clean-and-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-27b-clean-and-press-m5-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Triceps dip",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-1m-triceps-dip-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-1m-triceps-dip-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dumbbell farmer's walk",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-30d-dumbbell-farmers-walk-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-30d-dumbbell-farmers-walk-m5-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Palms-up wrist curl over bench",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2F14121101-Barbell-Palms-Up-Wrist-Curl-Over-A-Bench_Forearms_small.png?alt=media&token=bc4263d4-1108-48ae-a800-15ec96b27b27",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell Full Squat",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell%20Full%20Squat.jpeg?alt=media&token=5c8dfdc4-9054-4384-9496-10c6b1f14233",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell deficit deadlift",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell%20deficit%20deadlift.jpeg?alt=media&token=ea3f44f2-68f2-47a8-8dfc-bc1a4e0c000e",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell Deadlift",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell-Deadlift-1.png?alt=media&token=8835091d-fcde-4ea0-81a3-d10b9587f1d3",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm palm-in dumbbell shoulder press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSingle-arm%20palm-in%20dumbbell%20shoulder%20press.jpeg?alt=media&token=e486ebff-eb3c-42cd-ab93-95dd43f65332",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Romanian Deadlift With Dumbbells",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FRomanian%20Deadlift%20With%20Dumbbells.jpg?alt=media&token=4ea8dc86-a59b-4f40-9f6c-587ddeab8955",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Tire flip", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FTire%20flip.jpg?alt=media&token=b82de1ff-4332-4c24-bbcd-e662a731445b", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Clean Deadlift",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FClean%20Deadlift.jpg?alt=media&token=c866fcab-1c73-4be0-93ad-41c27c10adb5",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Elbow plank",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FElbow%20plank.jpeg?alt=media&token=9b7eed59-77a9-4c31-958c-37446a137675",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Bottoms Up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-63a-lying-leg-lift-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell back squat to box",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-72e-barbell-back-squat-to-box-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Clean and jerk",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26b-clean-and-jerk-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm kettlebell push-press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-67k-single-arm-kettlebell-push-press-m2-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-67k-single-arm-kettlebell-push-press-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Push-press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-39b-push-press-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Suspended ab fall-out",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-158s-suspended-ab-fall-out-m2-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Reverse Band Box Squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/753/Male/m/753_2.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Standing palms-in shoulder press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FStanding%20palms-in%20shoulder%20press.jpg?alt=media&token=a5319dfc-ff6d-4657-8d61-1b79c0fdad5e",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Standing cable low-to-high twist",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FStanding%20cable%20low-to-high%20twist.jpg?alt=media&token=294c0955-1414-467d-8147-00a916f433a5",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline EZ-bar skullcrusher",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-47n-decline-ez-bar-skullcrusher-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-47n-decline-ez-bar-skullcrusher-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing behind-the-back wrist curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-14b-standing-behind-the-back-wrist-curl-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated finger curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSeated%20finger%20curl.webp?alt=media&token=8a3395b0-ac57-4582-8206-ea5bcf0cae84",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Wide-grip barbell curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FWide-grip%20barbell%20curl.jpeg?alt=media&token=bc0c95a8-ceec-4a48-810d-3bda77f29482",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell spell caster",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDumbbell%20spell%20caster.webp?alt=media&token=1504ab7c-026e-4e92-86df-bd040b196003",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell floor press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2Fdumbbell-lying-on-floor-chest-press.webp?alt=media&token=4b64e7f7-aed8-48d2-a004-f65536467872",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Lying Face Down Plate Neck Resistance",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FLying%20Face%20Down%20Plate%20Neck%20Resistance.jpg?alt=media&token=c3dba228-512c-4f32-bc1b-5104ca6ba11e",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Pullups", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FPullups.webp?alt=media&token=56e85cd8-ae62-411e-b0ae-7a0b90d71735", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Dumbbell Bench Press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDumbbell%20Bench%20Press.jpg?alt=media&token=14f2ddd6-8ab3-4d04-98d6-251f6bed0f82",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Jumping rope",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FJumping%20rope.jpeg?alt=media&token=958b9813-be89-4984-ac3e-df5052f66d96",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated barbell shoulder press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSeated%20barbell%20shoulder%20press.png?alt=media&token=440be211-5895-4ecb-a107-356e785a7e44",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "EZ-bar spider curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18n-barbell-spider-curl-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Smith machine shrug",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSmith%20machine%20shrug.webp?alt=media&token=8e446f97-92bb-4299-9e46-cdd2802ef408",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Smith Machine Calf Raise",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSmith%20Machine%20Calf%20Raise.png?alt=media&token=b88be16f-1e60-496c-9b0c-3af13ca4584e",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Romanian Deadlift from Deficit",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FRomanian%20Deadlift%20from%20Deficit.jpg?alt=media&token=963cd616-8be1-49a2-9a7c-994915f42d5a",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Power Snatch",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FPower%20Snatch.jpg?alt=media&token=81cee665-d732-40e5-9a15-dd562ff67602",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Pushups", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FPushups.jpg?alt=media&token=85c885d5-036c-41e9-a53c-801f06983bf8", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Barbell walking lunge",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell%20walking%20lunge.jpg?alt=media&token=6a66286b-67af-46bc-bad0-89244b550e2e",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Front Squats With Two Kettlebells",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/511/Male/m/511_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/511/Male/m/511_2.jpg"
    },
    {
      "Exercise_Name": "Spider crawl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSpider%20crawl.webp?alt=media&token=ac550266-3826-4992-9797-2a0be15b7084",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Power Clean from Blocks",
      "Exercise_Image": "https://console.firebase.google.com/u/0/project/ironfit-edef8/storage/ironfit-edef8.appspot.com/files/~2Fexersices_imgs",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Two-Arm Palms-Up Low-Pulley Wrist Curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSeated%20Two-Arm%20Palms-Up%20Low-Pulley%20Wrist%20Curl.png?alt=media&token=a4c40719-8a94-452f-8db8-5e5ec5449e8a",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Hammer Curls",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-7d-hammer-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-7d-hammer-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Incline dumbbell bench press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-3n-incline-dumbbell-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-3n-incline-dumbbell-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Low-cable cross-over",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-5c-low-cable-cross-over-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-5c-low-cable-cross-over-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm high-cable side bend",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-107c-single-arm-high-cable-side-bend-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-107c-single-arm-high-cable-side-bend-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Single Leg Push-off",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/818/Male/m/818_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/818/Male/m/818_2.jpg"
    },
    {
      "Exercise_Name": "Hip Circles (Prone)",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/may/874_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/may/874_2.jpg"
    },
    {
      "Exercise_Name": "Reverse-grip bent-over row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-02b-reverse-grip-bent-over-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-02b-reverse-grip-bent-over-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Back extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-16m-back-extension-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-16m-back-extension-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Close-grip bench press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-82e-close-grip-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-82e-close-grip-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Cocoons",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-170a-cocoon-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-170a-cocoon-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Cross-Body Crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-176a-elbow-to-knee-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-176a-elbow-to-knee-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dumbbell Flyes",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-31e-dumbbell-chest-fly-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Dumbbell Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50e-seated-dumbbell-shoulder-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50e-seated-dumbbell-shoulder-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing dumbbell shoulder press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-104d-standing-dumbbell-shoulder-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-104d-standing-dumbbell-shoulder-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "EZ-Bar Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-46s-standing-ez-bar-curl-m1-crop-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Olympic Squat",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FOlympic%20Squat.jpeg?alt=media&token=441a192b-2559-469e-9f21-a929dfbc4666",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Natural Glute Ham Raise",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FNatural%20Glute%20Ham%20Raise.jpg?alt=media&token=d3923b44-e034-407a-a1ac-36ee5ce7d060",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Zottman Curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FZottman%20Curl.jpg?alt=media&token=2d9475cf-7c98-4930-8a1f-3f2cb5870b99",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Glute ham raise-",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FNatural%20Glute%20Ham%20Raise.jpg?alt=media&token=d3923b44-e034-407a-a1ac-36ee5ce7d060",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm lateral raise",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSingle-arm%20lateral%20raise.webp?alt=media&token=122d627a-8ffb-43cf-94fa-17e08082271e",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Power Partials",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FPower%20Partials.jpg?alt=media&token=d208cec4-5368-441c-a4c3-1c7701a084f8",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Leverage Shrug",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/898/Male/m/898_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/898_2.jpg"
    },
    {
      "Exercise_Name": "Cable V-bar push-down",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-17c-cable-v-bar-push-down-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-17c-cable-v-bar-push-down-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Wrist Roller",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/142/Male/m/142_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/142/Male/m/142_2.jpg"
    },
    {
      "Exercise_Name": "Incline dumbbell reverse fly",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-13n-incline-dumbbell-reverse-fly-m1-crop-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Stair climber",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FStair%20climber.jpg?alt=media&token=2626d1d5-1068-4527-afe7-9358c3f08c97",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Elbow-to-knee crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-176a-elbow-to-knee-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-176a-elbow-to-knee-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kettlebell Pistol Squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/521/Male/m/521_2.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Overhead dumbbell front raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-17d-overhead-dumbbell-front-raise-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Biceps curl to shoulder press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBiceps%20curl%20to%20shoulder%20press.jpg?alt=media&token=8e705490-b6dc-47a9-baf3-bc3b908b6b78",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Weighted bench dip",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FWeighted%20bench%20dip.jpeg?alt=media&token=60f0ef05-1662-4149-b2cd-5c565c27f2c1",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell Hip Thrust",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell%20Hip%20Thrust.webp?alt=media&token=69546193-a721-4a3c-9642-90aa92238ed0",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Forward lunge",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FForward%20lunge.jpg?alt=media&token=fb7f4d72-d8b3-4e50-8163-69c8759fae5e",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell Bench Press - Medium Grip",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell%20Bench%20Press%20-%20Medium%20Grip.jpg?alt=media&token=6006a79c-1afb-4996-891c-3e497eb6e1c0",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Chest dip", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FChest%20dip.jpg?alt=media&token=d36ddd46-cd27-43cb-923e-d5564ab7e8a8", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Seated dumbbell shoulder press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50e-seated-dumbbell-shoulder-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50e-seated-dumbbell-shoulder-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell Curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FWide-grip%20barbell%20curl.jpeg?alt=media&token=bc0c95a8-ceec-4a48-810d-3bda77f29482",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "EZ-Bar Skullcrusher",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-94s-ez-bar-skullcrusher-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-94s-ez-bar-skullcrusher-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "One-Arm Dumbbell Row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13e-single-arm-bench-dumbbell-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13e-single-arm-bench-dumbbell-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Alternating standing shoulder press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-93d-alternating-standing-shoulder-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-93d-alternating-standing-shoulder-press-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Concentration curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-8e-concentration-curl-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline Crunch",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDecline%20Crunch.jpeg?alt=media&token=636a36ef-b853-4daf-8ed6-942b5b54becf",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline Dumbbell Flyes",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-31n-decline-dumbbell-chest-fly-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm incline rear delt raise",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSingle-arm%20incline%20rear%20delt%20raise.jpg?alt=media&token=2b904d35-0717-472d-b433-b6ac1ef2e927",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Alternating dumbbell front raise",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FAlternating%20dumbbell%20front%20raise.png?alt=media&token=8148599f-d185-49b5-9bd5-c9cfaae5fdde",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Hanging toes-to-bar",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FHanging%20toes-to-bar.webp?alt=media&token=ac1943b9-edd5-4226-b145-af93bc66cd5e",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Narrow-stance squat",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FNarrow-stance%20squat.webp?alt=media&token=c1c9f09b-5a41-41aa-989d-e37412f383bc",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Kneeling cable oblique crunch",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FKneeling%20cable%20oblique%20crunch.jpg?alt=media&token=a843ef84-09e1-48a2-9761-495d6c766031",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Reverse Grip Triceps Pushdown",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-19c-reverse-grip-cable-straight-bar-push-down-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Bear crawl sled drag",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBear%20crawl%20sled%20drag.jpg?alt=media&token=b8b2d1a0-8c39-419b-8eb8-4570c9836dc4",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Thigh adductor",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FThigh%20adductor.jpeg?alt=media&token=399072cb-dbee-4aeb-b0e2-307b6fb865c6",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Machine Bicep Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/899/Male/m/899_2.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Palms-Down Barbell Wrist Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/389/Male/m/389_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/389/Male/m/389_2.jpg"
    },
    {
      "Exercise_Name": "Single-arm incline rear delt raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-14n-single-arm-incline-rear-delt-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-14n-single-arm-incline-rear-delt-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Alternating dumbbell front raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-14d-alternating-dumbbell-front-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-14d-alternating-dumbbell-front-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Hanging toes-to-bar",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-128c-hanging-toes-to-bar-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-128c-hanging-toes-to-bar-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Narrow-stance squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-30a-narrow-stance-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-30a-narrow-stance-squat-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kneeling cable oblique crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-36c-kneeling-cable-oblique-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-36c-kneeling-cable-oblique-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Reverse Grip Triceps Pushdown",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-19c-reverse-grip-cable-straight-bar-push-down-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-19c-reverse-grip-cable-straight-bar-push-down-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Bear crawl sled drag",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-153s-bear-crawl-sled-drag-m1-crop-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-153s-bear-crawl-sled-drag-m4-crop-600x600.jpg"
    },
    {
      "Exercise_Name": "Rocky Pull-Ups/Pulldowns",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/279/Male/m/279_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/279/Male/m/279_2.jpg"
    },
    {
      "Exercise_Name": "Flexor Incline Dumbbell Curls",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FFlexor%20Incline%20Dumbbell%20Curls.webp?alt=media&token=492ce430-ad9c-455f-aa17-c3d32be65415",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated One-Arm Dumbbell Palms-Up Wrist Curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSeated%20One-Arm%20Dumbbell%20Palms-Up%20Wrist%20Curl.jpg?alt=media&token=01dbdd91-bc4f-470e-80f9-f18e98e120e3",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Machine Bicep Curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FMachine%20Bicep%20Curl.webp?alt=media&token=e2840375-e1fd-485b-98e0-11486b2c356d",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Car driver",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FCar%20driver.jpg?alt=media&token=47c5eb75-1c30-4e74-992d-1dd5c05c4dd4",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Alternating Deltoid Raise",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FAlternating%20Deltoid%20Raise.png?alt=media&token=3d9cf460-b948-426a-9476-fdbb2ce9c63a",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Hanging Oblique Knee Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-120c-hanging-oblique-crunch-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-120c-hanging-oblique-crunch-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Bodyweight Flyes",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-182s-double-bar-roll-out-chest-fly-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-182s-double-bar-roll-out-chest-fly-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing Calf Raises",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-117s-standing-calf-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-117s-standing-calf-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Push-Ups - Close Triceps Position",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-104a-close-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-104a-close-push-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "One-Arm Long Bar Row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-124s-single-arm-landmine-bent-over-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-124s-single-arm-landmine-bent-over-row-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Overhead cable curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FOverhead%20cable%20curl.png?alt=media&token=b68cbeb5-533c-4bdf-b3c7-9a2ee3c56266",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-dumbbell front raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18d-single-dumbbell-front-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18d-single-dumbbell-front-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Incline cable chest fly",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-10c-incline-cable-chest-fly-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-10c-incline-cable-chest-fly-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-leg depth squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-68e-single-leg-depth-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-68e-single-leg-depth-squat-m4-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dumbbell suitcase crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50d-dumbbell-suitcase-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50d-dumbbell-suitcase-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Plate Twist",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/106/Male/m/106_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/106/Male/m/106_2.jpg"
    },
    {
      "Exercise_Name": "Single-leg cable hip extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-43c-single-leg-cable-hip-extension-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-43c-single-leg-cable-hip-extension-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Weighted Jump Squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/887/Male/m/887_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/887/Male/m/887_2.jpg"
    },
    {
      "Exercise_Name": "Gorilla Chin/Crunch",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FGorilla%20ChinCrunch.png?alt=media&token=8964d2f0-7518-4e07-ba4f-0c5ef1417ee1",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Kneeling cable triceps extension",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FKneeling%20cable%20triceps%20extension.jpeg?alt=media&token=0bc32f25-99cd-4920-bb6a-6a2bdad73910",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Kneeling Cable Crunch With Alternating Oblique Twists",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FKneeling%20Cable%20Crunch%20With%20Alternating%20Oblique%20Twists.jpeg?alt=media&token=680c5aca-ec6d-4b63-8ce9-9390d5a3c53c",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Bicycling", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBicycling.jpeg?alt=media&token=94d8fe75-77eb-4408-bd12-86aa5899006f", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Arnold press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FArnold%20press.jpeg?alt=media&token=4551808c-a563-49b2-8b04-d1a37f06af3d",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Weighted Crunches",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50d-dumbbell-suitcase-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50d-dumbbell-suitcase-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm cable triceps extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-31c-single-arm-cable-triceps-extension-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-31c-single-arm-cable-triceps-extension-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell roll-out",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48b-barbell-roll-out-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48b-barbell-roll-out-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kneeling cable crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-35c-kneeling-cable-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-35c-kneeling-cable-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Exercise Ball Pull-In",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FExercise%20Ball%20Pull-In.jpg?alt=media&token=c1cb2d6a-d090-4be6-bddd-fcd1820e34f2",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Hanging leg raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-9m-hanging-leg-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-9m-hanging-leg-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell Ab Rollout - On Knees",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48b-barbell-roll-out-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48b-barbell-roll-out-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell Squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50b-barbell-back-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50b-barbell-back-squat-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Decline barbell bench press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-34n-decline-barbell-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-34n-decline-barbell-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dumbbell Bicep Curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDumbbell%20Bicep%20Curl.png?alt=media&token=e27c17c7-8249-4350-9bcb-48b1fa600c9b",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell Goblet Squat",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDumbbell%20Goblet%20Squat.jpeg?alt=media&token=b708844a-2be4-4550-bbe2-b280ebd2b440",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell squat",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDumbbell%20squat.jpeg?alt=media&token=12dde43e-3358-4592-8b80-dbe76bc1551b",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell front squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-51b-barbell-front-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-51b-barbell-front-squat-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Close-grip pull-down",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FClose-grip%20pull-down.webp?alt=media&token=09198c46-6a30-4b67-8ef5-e80c700548a8",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Triceps Pushdown - Rope Attachment",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FTriceps%20Pushdown%20-%20Rope%20Attachment.jpg?alt=media&token=eda8bb2e-8ab3-4bde-bb2d-afb2484bc20e",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Side-to-side box skip",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-69e-side-to-side-box-skip-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-69e-side-to-side-box-skip-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Smith machine shoulder press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-alt-31t-smith-machine-shoulder-press-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated triceps press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSeated%20triceps%20press.jpeg?alt=media&token=620bc54e-fc8a-4bdf-8e35-1222e8abcc53",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell Lying Supination",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDumbbell%20Lying%20Supination.webp?alt=media&token=882d1c45-d0ce-40a5-9bb1-b20a1052e64f",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Pull-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-92c-pull-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-92c-pull-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Wide-grip bench press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-84e-wide-grip-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-84e-wide-grip-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Close-grip EZ-bar curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-47s-close-grip-ez-bar-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-47s-close-grip-ez-bar-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "T-Bar Row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/3381_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/3381_2.jpg"
    },
    {
      "Exercise_Name": "Bent Over Two-Arm Long Bar Row",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/18/Male/m/18_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/18/Male/m/18_2.jpg"
    },
    {"Exercise_Name": "Muscle Up", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FMuscle%20Up.webp?alt=media&token=55fbbb69-f720-411e-beaa-cd2557bf20c3", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Machine shoulder press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FMachine%20shoulder%20press.jpg?alt=media&token=b4b4aa89-119d-4d10-9df5-a8e7ae98575c",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Incline EZ-bar skullcrusher",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FIncline%20EZ-bar%20skullcrusher.jpeg?alt=media&token=edc7073d-2132-4a01-823a-e6059637bff0",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Alternating sit-through with crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-124s-single-arm-landmine-bent-over-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-124s-single-arm-landmine-bent-over-row-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Wide-Grip Decline Barbell Bench Press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FWide-Grip%20Decline%20Barbell%20Bench%20Press.png?alt=media&token=d31c0818-2388-487e-83ab-d64b43a7f888",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Rower", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FRower.jpg?alt=media&token=8b68a3a3-6822-42f8-8fe4-c1a45a14c1d0", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Snatch Deadlift",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSnatch%20Deadlift.jpg?alt=media&token=2035e916-6471-49fd-86c3-378434670609",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Front Plate Raise",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FFront%20Plate%20Raise.png?alt=media&token=dac18bae-01b6-48b7-a4d9-1ab7f75c2bfb",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline Close-Grip Bench To Skull Crusher",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/288/Male/m/288_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/288/Male/m/288_2.jpg"
    },
    {
      "Exercise_Name": "Lying Leg Curls",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20m-lying-leg-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20m-lying-leg-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Cross-body hammer curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-4d-cross-body-hammer-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-4d-cross-body-hammer-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Shotgun row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-37c-shotgun-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-37c-shotgun-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Ab Roller",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-2s-ab-wheel-roll-out-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-2s-ab-wheel-roll-out-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Reverse-grip incline dumbbell bench press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-4n-reverse-grip-incline-dumbbell-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-4n-reverse-grip-incline-dumbbell-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Leg Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-44m-leg-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-44m-leg-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Stiff-Legged Dumbbell Deadlift",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-9d-dumbbell-stiff-legged-deadlift-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-9d-dumbbell-stiff-legged-deadlift-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Cable Crossover",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FCable%20Crossover.webp?alt=media&token=44abc72d-5df6-4738-bba8-8e3bd8e24bb6",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell Incline Bench Press Medium-Grip",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell%20Incline%20Bench%20Press%20Medium-Grip.jpeg?alt=media&token=32096fb3-dbf6-4257-99ca-6afda9d95d6c",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Incline Dumbbell Flyes",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FIncline%20Dumbbell%20Flyes.webp?alt=media&token=3904c78a-fef2-4283-ba2f-cb98f5809b7f",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Cable Rows",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSeated%20Cable%20Rows.png?alt=media&token=fae44f16-47af-445b-927d-52542df99782",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Tricep Dumbbell Kickback",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-76d-single-arm-triceps-kick-back-m2-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-76d-single-arm-triceps-kick-back-m3-square-600x600.jpg"
    },
    {"Exercise_Name": "Otis-Up", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FOtis-Up.webp?alt=media&token=ad81867f-5d2e-403d-841e-abcb4921b3b1", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Mountain climber",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-201a-mountain-climber-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-201a-mountain-climber-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Ab bicycle",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-73a-ab-cycle-m2-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-73a-ab-cycle-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell forward lunge",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-43b-barbell-forward-lunge-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-43b-barbell-forward-lunge-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "3/4 sit-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-149a-34-sit-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-149a-34-sit-up-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Exercise ball leg curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-21s-exercise-ball-leg-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-21s-exercise-ball-leg-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Glute bridge",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-59a-glute-bridge-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-59a-glute-bridge-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Close-Grip Front Lat Pulldown",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-73c-close-grip-pull-down-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-73c-close-grip-pull-down-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dip Machine",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/146/Male/m/146_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/146/Male/m/146_2.jpg"
    },
    {
      "Exercise_Name": "Incline dumbbell row",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FIncline%20dumbbell%20row.jpeg?alt=media&token=fd420998-f8cf-48ad-b5e6-19f916017ed2",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell Lunges",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDumbbell%20Lunges.jpeg?alt=media&token=77aa5260-3574-476d-8338-d3601b0f4efa",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm standing shoulder press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSingle-arm%20standing%20shoulder%20press.jpeg?alt=media&token=7a6b6aac-cb42-4941-8471-d2c2fad7d026",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Preacher Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-55s-ez-bar-preacher-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-55s-ez-bar-preacher-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Reverse crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-263a-reverse-crunch-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-263a-reverse-crunch-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing Dumbbell Triceps Extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/june/345_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/june/345_2.jpg"
    },
    {
      "Exercise_Name": "Elliptical trainer",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-22m-elliptical-trainer-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-22m-elliptical-trainer-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Bodyweight squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-27a-bodyweight-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-27a-bodyweight-squat-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Bent Over Two-Dumbbell Row With Palms In",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/17/Male/m/17_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/17/Male/m/17_2.jpg"
    },
    {
      "Exercise_Name": "Hex-bar deadlift",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-123s-hex-bar-deadlift-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-123s-hex-bar-deadlift-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Narrow-stance leg press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-46m-wide-stance-leg-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-46m-wide-stance-leg-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-leg glute bridge",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-61a-single-leg-glute-bridge-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-61a-single-leg-glute-bridge-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell Curls Lying Against An Incline",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/300/Male/m/300_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/300/Male/m/300_2.jpg"
    },
    {
      "Exercise_Name": "Standing Hip Circles",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/873/Male/m/873_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/873/Male/m/873_2.jpg"
    },
    {
      "Exercise_Name": "Clam",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/april/2843_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/april/2843_2.jpg"
    },
    {
      "Exercise_Name": "Narrow Stance Hack Squats",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FNarrow%20Stance%20Hack%20Squats.png?alt=media&token=134385c1-8fb4-452a-a6fb-af559ba895d7",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Close-Grip Concentration Barbell Curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSeated%20Close-Grip%20Concentration%20Barbell%20Curl.webp?alt=media&token=7c85d0bc-6d08-4fec-95a5-b4d6b0853948",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Smith machine box squat",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSmith%20machine%20box%20squat.webp?alt=media&token=80aad97c-9327-4ddd-97d4-bd6080b24c45",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Drop Push", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDrop%20Push.jpeg?alt=media&token=df83913f-a352-4246-9c20-b9caab248d80", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Upside-down pull-up",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FUpside-down%20pull-up.jpeg?alt=media&token=a2b5736d-42c8-44ce-9c76-126ef91e22e4",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Reverse Barbell Preacher Curls",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FReverse%20Barbell%20Preacher%20Curls.jpeg?alt=media&token=d7f1a37a-8801-4d24-9ee8-6116733ac343",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Close-grip EZ-bar bench press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FClose-grip%20EZ-bar%20bench%20press.jpeg?alt=media&token=ab12b1ec-11a5-4570-bd5a-89276b629ece",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Incline Push-Up",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FIncline%20Push-Up.jpeg?alt=media&token=2dad6d98-185e-4b6f-a957-1e0da7fb69ad",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Hyperextensions With No Hyperextension Bench",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FHyperextensions%20With%20No%20Hyperextension%20Bench.jpg?alt=media&token=e8de5b57-563f-4179-af7c-0b42a0c136ba",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell front raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13d-dumbbell-front-raise-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Parallel Bar Dip",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-1m-triceps-dip-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-1m-triceps-dip-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Stairmaster",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-51m-stair-climber-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-51m-stair-climber-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Double Leg Butt Kick",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/778/Male/m/778_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/778/Male/m/778_2.jpg"
    },
    {"Exercise_Name": "Groiners", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FGroiners.png?alt=media&token=cd984d79-d2b3-453b-8e2f-bdcec69731d9", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Neck Press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FNeck%20Press.webp?alt=media&token=42191601-c09f-4089-bb4f-7fc21e81d70f",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "V-bar pull-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-140c-v-bar-pull-up-m1-crop-600x600.jpg",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Ring dip", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FRing%20dip.jpg?alt=media&token=3fa2091e-edb9-4c31-90ee-31dee41c24ef", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Standing One-Arm Cable Curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FStanding%20One-Arm%20Cable%20Curl.jpeg?alt=media&token=9784b6c0-c8a1-48e9-a825-81315132a39f",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Burpee",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-38a-burpee-m4-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Double-arm triceps kick-back",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-75d-double-arm-triceps-kick-back-m2-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-75d-double-arm-triceps-kick-back-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dumbbell reverse lunge",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-83d-dumbbell-reverse-lunge-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Calf Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13m-machine-seated-calf-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13m-machine-seated-calf-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing dumbbell shrug",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-115d-standing-dumbbell-shrug-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-115d-standing-dumbbell-shrug-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell step-up",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell%20step-up.jpeg?alt=media&token=ecddf7c2-870a-43e2-ad06-9c7432e02493",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Feet-elevated bench dip",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FFeet-elevated%20bench%20dip.jpg?alt=media&token=24d70876-6778-4982-9d64-4c262ed45431",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Bent Over Barbell Row",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBent%20Over%20Barbell%20Row.jpeg?alt=media&token=44f4bd7f-804f-4ee1-9fae-04ab7aac7d89",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell Alternate Bicep Curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDumbbell-Curl.gif?alt=media&token=3e7b5e7b-3466-4078-b62c-1a1019f5dab2",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Bent-over dumbbell rear delt row",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBent-over%20dumbbell%20rear%20delt%20row.png?alt=media&token=77240ff5-2b8b-446b-ac00-f93184995765",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "External Rotation with Cable",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FExternal%20Rotation%20with%20Cable.png?alt=media&token=17620890-0036-4aef-9d44-aa312e573d0d",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm dumbbell preacher curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-53s-single-arm-dumbbell-preacher-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-53s-single-arm-dumbbell-preacher-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Step-up with knee raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-70e-step-up-with-knee-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-70e-step-up-with-knee-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Smith machine back squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18t-smith-machine-back-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18t-smith-machine-back-squat-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Alternate Incline Dumbbell Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26n-alternating-incline-dumbbell-biceps-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26n-alternating-incline-dumbbell-biceps-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing dumbbell upright row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-125d-standing-dumbbell-upright-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-125d-standing-dumbbell-upright-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm cable front raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-42c-single-arm-cable-front-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-42c-single-arm-cable-front-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Two-Arm Kettlebell Military Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/530/Male/m/530_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/530/Male/m/530_2.jpg"
    },
    {
      "Exercise_Name": "Incline cable chest press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11c-incline-cable-chest-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11c-incline-cable-chest-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Step-up with knee raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-70e-step-up-with-knee-raise-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Incline dumbbell front raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11n-incline-dumbbell-front-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11n-incline-dumbbell-front-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Rope climb",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-155s-rope-climb-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-155s-rope-climb-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing Bradford press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FStanding%20Bradford%20press.png?alt=media&token=075f8e7f-e9d5-4342-930d-ef88c44a2474",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Neutral-grip dumbbell bench press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FNeutral-grip%20dumbbell%20bench%20press.jpeg?alt=media&token=14c2ca59-a2ed-4eb1-b41c-85cf90e2d2d2",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Cable Chest Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/870/Male/m/870_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/870/Male/m/870_2.jpg"
    },
    {
      "Exercise_Name": "Standing concentration curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-23d-standing-concentration-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-23d-standing-concentration-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Wide-Grip Rear Pull-Up",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/191/Male/m/191_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/191/Male/m/191_2.jpg"
    },
    {
      "Exercise_Name": "Kettlebell pass-through lunge",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-57k-kettlebell-pass-through-lunge-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-57k-kettlebell-pass-through-lunge-m4-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Hands-elevated push-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18e-hands-elevated-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18e-hands-elevated-push-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Deadlift with Bands",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/677/Male/m/677_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/677/Male/m/677_2.jpg"
    },
    {
      "Exercise_Name": "Straight-arm rope pull-down",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-105c-straight-arm-rope-pull-down-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-105c-straight-arm-rope-pull-down-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell Shoulder Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48e-seated-barbell-shoulder-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48e-seated-barbell-shoulder-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Power clean",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-25b-power-clean-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-25b-power-clean-m4-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Hang Snatch",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/690/Male/m/690_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/690/Male/m/690_2.jpg"
    },
    {
      "Exercise_Name": "Kettlebell sumo deadlift high pull",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-49k-kettlebell-sumo-deadlift-high-pull-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-49k-kettlebell-sumo-deadlift-high-pull-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Calf-Machine Shoulder Shrug",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/184/Male/m/184_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/184/Male/m/184_2.jpg"
    },
    {
      "Exercise_Name": "Bench Press - Powerlifting",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/663/Male/m/663_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/663/Male/m/663_2.jpg"
    },
    {
      "Exercise_Name": "Rocking Standing Calf Raise",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FRocking%20Standing%20Calf%20Raise.jpeg?alt=media&token=fdbf6be1-cfe4-4bfc-a004-f884d024dd33",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Goblet Squat",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FGoblet%20Squat.jpg?alt=media&token=09460f4b-4170-4a60-975d-141e66c905a3",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Behind-the-head skullcrusher",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-56e-behind-the-head-skullcrusher-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-56e-behind-the-head-skullcrusher-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Seated palms-up wrist curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-65e-seated-palms-up-wrist-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-65e-seated-palms-up-wrist-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Reverse Cable Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/141/Male/m/141_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/141/Male/m/141_2.jpg"
    },
    {
      "Exercise_Name": "Dumbbell side bend",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-102d-dumbbell-side-bend-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-102d-dumbbell-side-bend-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Lat pull-down",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-72c-lat-pull-down-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Side Lateral Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-77d-dumbbell-lateral-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-77d-dumbbell-lateral-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Alternating incline dumbbell biceps curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26n-alternating-incline-dumbbell-biceps-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26n-alternating-incline-dumbbell-biceps-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kettlebell One-Legged Deadlift",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-4k-single-leg-kettlebell-deadlift-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Alternate Hammer Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-3d-alternating-hammer-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-3d-alternating-hammer-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Decline Push-Up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20e-feet-elevated-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20e-feet-elevated-push-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Captain's chair knee raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-5m-captains-chair-knee-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-5m-captains-chair-knee-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Triceps Pushdown",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-17c-cable-v-bar-push-down-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-17c-cable-v-bar-push-down-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Low cable overhead triceps extension",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FLow%20cable%20overhead%20triceps%20extension.jpg?alt=media&token=4c666697-0943-4178-9727-ab1db0648f9d",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm cable cross-over",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSingle-arm%20cable%20cross-over.jpg?alt=media&token=d84cbda1-535a-4509-a82f-d31108736247",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated dumbbell biceps curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSeated%20dumbbell%20biceps%20curl.webp?alt=media&token=ac6555a8-6708-493f-ae69-ab890b547935",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Battle ropes",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBattle%20ropes.jpg?alt=media&token=1856f489-d813-4f36-a186-daf1590b0efa",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dead bug reach",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDead%20bug%20reach.png?alt=media&token=8b5233f0-d176-4525-aec3-04f7404da5df",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Rope Crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-35c-kneeling-cable-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-35c-kneeling-cable-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kettlebell thruster",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FKettlebell%20thruster.jpg?alt=media&token=c9f556ac-a68c-41d9-9edf-b2c1e0fda462",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-Arm Push-Up",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSingle-Arm%20Push-Up.jpeg?alt=media&token=958d4301-24f4-4a6b-aa64-05f1d7f3e201",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Band Hip Adductions",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/850/Male/m/850_2.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm kettlebell clean",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-80k-single-arm-kettlebell-clean-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-80k-single-arm-kettlebell-clean-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Preacher Hammer Dumbbell Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/155/Male/m/155_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/155/Male/m/155_2.jpg"
    },
    {
      "Exercise_Name": "Alternating Kettlebell Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/504/Male/m/504_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/504/Male/m/504_2.jpg"
    },
    {
      "Exercise_Name": "Split Squat with Dumbbells",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-61e-dumbbell-bulgarian-split-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-61e-dumbbell-bulgarian-split-squat-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kneeling Squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/697/Male/m/697_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/697/Male/m/697_2.jpg"
    },
    {
      "Exercise_Name": "Close-grip barbell curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20b-close-grip-barbell-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20b-close-grip-barbell-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Leverage Incline Chest Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/893/Male/m/893_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/893/Male/m/893_2.jpg"
    },
    {
      "Exercise_Name": "Kettlebell Turkish Get-Up (Squat style)",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/527/Male/m/527_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/527/Male/m/527_2.jpg"
    },
    {
      "Exercise_Name": "Crunch - Hands Overhead",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/113/Male/m/113_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/113/Male/m/113_2.jpg"
    },
    {
      "Exercise_Name": "Cable Internal Rotation",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/315/Male/m/315_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/315/Male/m/315_2.jpg"
    },
    {
      "Exercise_Name": "Leg Extensions",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18m-leg-extension-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18m-leg-extension-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing One-Arm Dumbbell Curl Over Incline Bench",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/339/Male/m/339_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/339/Male/m/339_2.jpg"
    },
    {
      "Exercise_Name": "Standing Olympic Plate Hand Squeeze",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/6/Male/m/6_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/6/Male/m/6_2.jpg"
    },
    {
      "Exercise_Name": "Sledgehammer swing",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-186s-sledghehammer-swing-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-186s-sledghehammer-swing-m3-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm kettlebell snatch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-79k-single-arm-kettlebell-snatch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-79k-single-arm-kettlebell-snatch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Box jump",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-75e-box-jump-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-75e-box-jump-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing cable crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-34c-standing-cable-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-34c-standing-cable-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing barbell overhead triceps extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-60b-standing-barbell-overhead-triceps-extension-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-60b-standing-barbell-overhead-triceps-extension-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Lying cable triceps extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62c-lying-cable-triceps-extension-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62c-lying-cable-triceps-extension-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Decline dumbbell bench press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-33n-decline-dumbbell-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-33n-decline-dumbbell-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "V-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-76a-v-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-76a-v-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell Bulgarian split squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-60e-barbell-bulgarian-split-squat-m1-crop-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-60e-barbell-bulgarian-split-squat-m2-crop-600x600.jpg"
    },
    {
      "Exercise_Name": "Reverse-grip lat pull-down",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-74c-reverse-grip-lat-pull-down-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-74c-reverse-grip-lat-pull-down-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing Biceps Cable Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-22c-cable-straight-bar-biceps-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-22c-cable-straight-bar-biceps-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm cable seated row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-82c-single-arm-cable-seated-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-82c-single-arm-cable-seated-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm kettlebell row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-12e-single-arm-dumbbell-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-12e-single-arm-dumbbell-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Scissors Jump",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-42a-alternating-lunge-jump-m4-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-42a-alternating-lunge-jump-m5-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Wide Stance Stiff Legs",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/744/Male/m/744_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/744/Male/m/744_2.jpg"
    },
    {
      "Exercise_Name": "Rack Pull with Bands",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/741/Male/m/741_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/741/Male/m/741_2.jpg"
    },
    {
      "Exercise_Name": "Drag curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11b-drag-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11b-drag-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Close push-up to wide push-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-105a-close-push-up-to-wide-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-105a-close-push-up-to-wide-push-up-m4-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm dumbbell triceps extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-130d-single-arm-dumbbell-triceps-extension-m2-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-130d-single-arm-dumbbell-triceps-extension-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Butterfly",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-53m-machine-chest-fly-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-53m-machine-chest-fly-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Seated face pull",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-70c-seated-face-pull-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-70c-seated-face-pull-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dumbbell external shoulder rotation",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDumbbell%20external%20shoulder%20rotation.webp?alt=media&token=55829d40-5b61-49e6-90e0-690d401d6830",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm bent-over cable rear delt fly",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48c-single-arm-cable-rear-delt-fly-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48c-single-arm-cable-rear-delt-fly-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Clean",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/669/Male/m/669_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/669/Male/m/669_2.jpg"
    },
    {
      "Exercise_Name": "Single-arm incline lateral raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-24n-single-arm-incline-lateral-raise-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline bar press sit-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-44n-decline-press-sit-up-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell rear delt bent-over row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-03b-barbell-rear-delt-bent-over-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-03b-barbell-rear-delt-bent-over-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Calf Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-117s-standing-calf-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-117s-standing-calf-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kettlebell alternating renegade row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11k-kettlebell-alternating-renegade-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11k-kettlebell-alternating-renegade-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Bosu Ball Cable Crunch With Side Bends",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/932/Male/m/932_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/932/Male/m/932_2.jpg"
    },
    {
      "Exercise_Name": "Stomach Vacuum",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/243/Male/m/243_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/243/Male/m/243_2.jpg"
    },
    {
      "Exercise_Name": "Hammer Grip Incline DB Bench Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/60/Male/m/60_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/60/Male/m/60_2.jpg"
    },
    {
      "Exercise_Name": "Wide-grip hands-elevated push-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-19e-wide-grip-hands-elevated-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-19e-wide-grip-hands-elevated-push-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Decline Dumbbell Triceps Extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/167/Male/m/167_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/167/Male/m/167_2.jpg"
    },
    {
      "Exercise_Name": "Jumping jack-",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FJumping%20jack-.png?alt=media&token=24235f82-0fab-4bb8-ba5f-dc4ab21003c2",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Push-Ups With Feet On An Exercise Ball",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FPush-Ups%20With%20Feet%20On%20An%20Exercise%20Ball.jpg?alt=media&token=a48471f6-f365-48b3-9c61-7c02fb46de1e",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated cable shoulder press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSeated%20cable%20shoulder%20press.jpg?alt=media&token=60ce6201-5d91-4d67-bd4a-5600eccf13e0",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell hack squat",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell%20hack%20squat.jpeg?alt=media&token=acb166fb-9f28-4965-9bb3-d4ae5f828c06",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Feet-elevated push-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20e-feet-elevated-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20e-feet-elevated-push-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Good Morning",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-09b-barbell-good-morning-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-09b-barbell-good-morning-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Leverage Chest Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-65m-machine-chest-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-65m-machine-chest-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Gironda Sternum Chins",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/292/Male/m/292_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/292/Male/m/292_2.jpg"
    },
    {
      "Exercise_Name": "Exercise ball crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-23s-exercise-ball-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-23s-exercise-ball-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Seated rear delt fly",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-47e-seated-rear-delt-fly-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-47e-seated-rear-delt-fly-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing face pull",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-40c-standing-face-pull-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-40c-standing-face-pull-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Glute Ham Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-25m-glute-ham-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-25m-glute-ham-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Russian twist",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-262a-russian-twist-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-262a-russian-twist-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Seated Flat Bench Leg Pull-In",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/93/Male/m/93_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/93/Male/m/93_2.jpg"
    },
    {
      "Exercise_Name": "Barbell shrug",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-04b-barbell-shrug-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-04b-barbell-shrug-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing cable rear delt row",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FStanding%20cable%20rear%20delt%20row.jpg?alt=media&token=57234135-72fd-4b00-a4b7-1801f9e630df",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Flat Bench Lying Leg Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-63a-lying-leg-lift-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-63a-lying-leg-lift-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dumbbell skullcrusher",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDumbbell%20skullcrusher.jpg?alt=media&token=8b6edc5e-aaa0-4848-9d9c-15c0fbdc908d",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Man-maker", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FMan-maker.jpeg?alt=media&token=ffe216da-7ae6-405f-9c6b-371ff2b2fa17", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Pallof press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FPallof%20press.webp?alt=media&token=3041299c-b3ae-4490-907b-728917157351",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Knees tucked crunch",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FKnees%20tucked%20crunch.webp?alt=media&token=5c648158-c9f4-4935-aa6d-aa8a85638af1",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Straight-arm dumbbell pull-over",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26e-straight-arm-dumbbell-pull-over-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26e-straight-arm-dumbbell-pull-over-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Arms-crossed jump squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-43a-arms-crossed-jump-squat-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline Smith Machine Chest Press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDecline%20Smith%20Machine%20Chest%20Press.jpeg?alt=media&token=ead1e107-4bfa-4720-b3bf-9fc4209f1dca",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Band Skull Crusher",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/1211/Male/m/1211_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/1211/Male/m/1211_2.jpg"
    },
    {
      "Exercise_Name": "Side Wrist Pull",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/442/Male/m/442_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/442/Male/m/442_2.jpg"
    },
    {
      "Exercise_Name": "Isometric Wipers",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-122a-typewriter-push-up-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Cable cross-over",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-1c-cable-cross-over-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-1c-cable-cross-over-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Treadmill running",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FTreadmill%20running.jpeg?alt=media&token=c8607acf-6a72-4dc3-a38c-33b99397b7ed",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "One Arm Pronated Dumbbell Triceps Extension",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FOne%20Arm%20Pronated%20Dumbbell%20Triceps%20Extension.jpg?alt=media&token=75027b01-cca5-4cf6-8513-f0124bf8eb60",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Side To Side Chins",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSide%20To%20Side%20Chins.png?alt=media&token=93e3ed30-daf8-4bf7-8490-205d14de8c4a",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Incline Dumbbell Bench With Palms Facing In",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FIncline%20Dumbbell%20Bench%20With%20Palms%20Facing%20In.png?alt=media&token=0ba093ad-bd0f-48a2-b24c-034f7bea831f",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated palms-down wrist curl",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSeated%20palms-down%20wrist%20curl.jpg?alt=media&token=edb51d1e-8ff6-49bc-8816-52953a0a54f7",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Standing leg swing",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-83s-standing-leg-swing-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-83s-standing-leg-swing-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Clock push-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-103a-clock-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-103a-clock-push-up-m6-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Machine seated row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-91m-machine-seated-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-91m-machine-seated-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Lying Face Up Plate Neck Resistance",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/26/Male/m/26_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/26/Male/m/26_2.jpg"
    },
    {
      "Exercise_Name": "Weighted sissy squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-180s-weighted-sissy-squat-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-180s-weighted-sissy-squat-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Jog In Place",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/2963_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/2963_2.jpg"
    },
    {
      "Exercise_Name": "Dumbbell Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/327/Male/m/327_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/327/Male/m/327_2.jpg"
    },
    {
      "Exercise_Name": "Palms-Down Dumbbell Wrist Curl Over A Bench",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/4/Male/m/4_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/4/Male/m/4_2.jpg"
    },
    {
      "Exercise_Name": "One Arm Supinated Dumbbell Triceps Extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/362/Male/m/362_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/362/Male/m/362_2.jpg"
    },
    {
      "Exercise_Name": "Dumbbell bent-over row",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FDumbbell%20bent-over%20row.webp?alt=media&token=5612038f-d581-4a7a-a6ea-99e680a15895",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Flutter Kicks",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FFlutter%20Kicks.webp?alt=media&token=cbf4221c-72e3-4c4f-8972-e857b35839b7",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell upright row",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell%20upright%20row.webp?alt=media&token=8d1d2b81-71c5-46e8-86a9-4d8ed431c3a2",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Superman", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSuperman.webp?alt=media&token=b3473337-85a4-4c74-b0e7-cfc5ddcfea08", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Straight-Arm Pulldown",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-104c-straight-arm-bar-pull-down-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-104c-straight-arm-bar-pull-down-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing One-Arm Dumbbell Triceps Extension",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FStanding%20One-Arm%20Dumbbell%20Triceps%20Extension.webp?alt=media&token=683d5e51-82c0-4b94-ae61-f50c63b3adce",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Side Lateral Raise",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSeated%20Side%20Lateral%20Raise.webp?alt=media&token=6018540a-92d0-46b8-b227-3c9001426c96",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell Lying Rear Lateral Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13n-incline-dumbbell-reverse-fly-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13n-incline-dumbbell-reverse-fly-m2-square-600x600.jpg"
    }
]
  ''';
