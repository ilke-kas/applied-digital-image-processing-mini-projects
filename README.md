# 📚 Digital Image Processing Mini Projects (MATLAB)

This repository contains a **series of applied image processing projects** implemented in MATLAB, covering **fundamentals, advanced techniques, and morphology/noise reduction**.  
Each stage demonstrates **mathematical reasoning, implementation, and detailed experimental analysis** with visual results.  

> 🚀 Originally inspired by coursework, these projects are reframed as a **portfolio series** to highlight practical skills in computer vision, image filtering, and digital signal processing.

---

## 📂 Repository Structure
```text
├── README.md                                ← this file
├── Fundamentals/                            ← low-level DIP basics
│   ├── src/                                 ← MATLAB scripts
│   └── images/                              ← figures/results
├── Analysis and Filtering/                                ← filtering & frequency-domain
│   ├── src/
│   └── images/
├── Morphology_NoiseReduction/               ← morphology & noise reduction
│   ├── src/
│   └── images/
```

---

## 🔍 Series Overview
- **Fundamentals**  
  Color detection, adjacency, geometric transformations, contrast stretching, histogram equalization, convolution bias, Gaussian filters, filtering order, unsharp masking.  
- **Advanced**  
  Synthetic images, quantization, Sobel & gradient edge detection, box filtering vs unsharp masking, Fourier-derived one-pass filters, histogram-constrained images, histogram equalization, high-boost filtering, Gaussian frequency filters, sampling theory & zero-padding.  
- **Morphology & Noise Reduction**  
  PSNR/MSE/SSIM comparisons, Gaussian vs salt-and-pepper filtering, variance reduction theory, morphological opening/closing, noise removal pipelines, separating touching objects, region labeling, gradients.  

---

## 📘 Detailed Highlights

### Fundamentals
- 🚗 **Car Color Detection** with optical filters + grayscale camera.  
- 🔗 **Adjacency & Shortest Paths**: explored 4-, 8-, and m-adjacency.  
- 🔄 **Geometric Transformations**: scaling, rotation, shear.  
- 🌈 **Contrast Stretching** to enhance intensity range.  
- 📊 **Histogram Equalization (double pass)** showing idempotency.  
- ⚖️ **Smoothing vs Laplacian Order** demonstrating why filter order matters.  
- ✨ **Unsharp Masking Kernel** derived via Fourier transforms.  

---

### Analysis and Filtering
- 🖼 **Synthetic Image Generation** (stripes, ramps, Gaussian blobs, quadrants).  
- 🎨 **Quantization & False Contours**: perceptual limits analysis.  
- 🪶 **Edge Detection**: Sobel, |Gx|+|Gy|, and gradient magnitude.  
- 📉 **Box Filtering vs Unsharp Masking** trade-offs.  
- ⚡ **Fourier-Derived Equivalent Filters** (box + Laplacian).  
- 📊 **Histogram-Constrained Images** → diverging after filtering.  
- 🧾 **Custom Histogram Equalization** vs MATLAB `histeq`.  
- 🔥 **High-Boost Filtering & Gaussian Frequency Filters** (anisotropic effects).  
- 🕒 **Sampling & Nyquist** validation, plus zero-padding effects.  

---

### Morphology & Noise Reduction
- 🖼 **Boat Image Filtering**: box vs median filter → PSNR/MSE/SSIM comparisons.  
- 🎯 **Gaussian vs Salt-Pepper Noise** → Wiener filter vs median.  
- 📉 **Variance Theory Validation** with averaging filters.  
- 🧹 **Morphological Opening vs Closing** (`drink.png`).  
- 🎛 **Pipeline Noise Reduction** (opening + closing).  
- ⚪ **Separating Touching Objects** via erosion.  
- ➖ **Circle vs Line Separation** with structuring elements.  
- 🔍 **Fingerprint & Text Cleaning**, **City Gradients**.  

---

## 🎓 Key Learning Outcomes
- Fundamentals of **intensity transformations** and geometric operations.  
- Advanced **filtering, frequency-domain techniques, and sampling theory**.  
- Robust **noise reduction and morphological object processing**.  
- Practical use of **evaluation metrics**: PSNR, MSE, SSIM.  
- MATLAB coding practices with **custom helper functions**.  

---

## 🛠️ Tools
- MATLAB (R2023a)  
- Image Processing Toolbox  

---

## 📜 References
- Gonzalez & Woods, *Digital Image Processing* (4th Edition).  
- MATLAB Documentation (`fspecial`, `imfilter`, `histeq`, `regionprops`, etc.).  
- Supplemental academic notes on **Gaussian filters**, **histogram equalization**, and **morphology**.  

---

## 👩‍💻 Author
**Ilke Kas**  
Graduate Researcher – Robotics & Computer Vision  
[LinkedIn](https://www.linkedin.com/) | [GitHub](https://github.com/ilkekas)  
