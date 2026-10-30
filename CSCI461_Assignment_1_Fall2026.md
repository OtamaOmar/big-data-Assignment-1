**Nile University \| CSCI461 Introduction to Big Data \| Fall 2026**   
Assignment \#1 

**Total: 20 Marks \| Bonus: 2 Marks \| Team Assignment** 

**1\. General Instructions** 

• Teams should contain 3-4 students. Every member must understand and be able to explain all project components during  discussion. 

• Choose ONE dataset from the six approved options in Section 8\. Do not replace it with another one without approval. • All analysis and modeling must run successfully inside the Docker container. A notebook that only works on the host machine  is incomplete. 

• The notebook must run from top to bottom after Kernel \-\> Restart and Run All. 

• Your README must include all Docker commands needed to reproduce the project from the machine. **2\. Required Project Structure**   
bd-a1/   
├── Dockerfile   
├── requirements.txt 

├── README.md   
├── data/   
│ └── dataset.csv   
├── notebook/   
│ └── analysis.ipynb   
├── output/   
│ ├── cleaned\_data.csv   
│ ├── model\_metrics.txt 

│ ├── cluster\_summary.txt   
│ └── figures/   
└── screenshots/ 

**Important:** The project files must be prepared on the host before building the image. Do not create the analysis files manually  only after entering the running container. 

**3\. Docker Environment and Reproducibility \[5 Marks\]** 

**3.1 Custom Image \[2 Marks\]** 

• Use quay.io/jupyter/scipy-notebook:latest as the base image. 

• Install any additional packages using requirements.txt 

• Create a folder in the image and copy the empty notebook and dataset into the image. 

• Set WORKDIR to the created folder 

**3.2 Run the JupyterLab \[1 Mark\]** 

• Open JupyterLab and execute your notebook inside the container. 

• In the README, explain image vs. container and HOST\_PORT:CONTAINER\_PORT for \-p 8888:8888. **3.3 Persistent Output with a Bind Mount \[1 Mark\]**   
• All final CSV files, metrics and figures must be saved under output/, so they remain available on the host even if the container  is removed. 

**3.4 Container Lifecycle Evidence \[0.5 Mark\]** 

• Demonstrate and document: docker images, docker ps, docker ps \-a, docker logs, and docker inspect. • Include screenshots proving that your custom image and running container exist. 

**3.5 Docker Hub Distribution \[0.5 Mark\]** 

• Tag the final custom image using your Docker Hub username, push it to Docker Hub, then document the repository name and  tag in the README. 

• Another team member must pull the published image and run it successfully to verify reproducibility.

Assignment \#1 \- Dockerized Data, Text Analysis and Machine Learning   
**Nile University \| CSCI461 Introduction to Big Data \| Fall 2026**   
**4\. Data Analysis and Preprocessing \[5 Marks\]** 

**Dataset understanding:** Load the data; show head, shape, columns, dtypes, info and descriptive statistics. Explain what one row  represents and identify text, label/category and numerical columns. 

**Missing values and duplicates:** Report missing values per column and duplicates. Apply an appropriate treatment and justify  your decision. Show shape before and after cleaning. 

**loc / iloc:** Use loc for a meaningful conditional selection; use iloc for positional selection; include at least one iloc example using  np.r\_. 

**Transformation / feature creation:** Apply at least three appropriate transformations such as type conversion, encoding, binning,  normalization, category consolidation or feature creation. 

**Sampling:** Perform simple random, stratified and cluster sampling. Compare the original and sampled class/category distributions  and explain the difference among the three methods. 

**Correlation:** Create at least four numerical text features (e.g., char\_count, word\_count, unique\_word\_count, avg\_word\_length).  Compute a correlation matrix/heatmap and interpret strong/weak relationships. State why correlation does not imply causation. 

**5\. Text Analysis \[4 Marks\]** 

• Create a new cleaned\_text column while keeping the original text unchanged. 

• At minimum: lowercase, handle missing text, remove unnecessary punctuation and extra spaces; handle URLs/numbers  when relevant. 

• Tokenize the cleaned text and report total tokens, unique words and average words per record. • Show the 20 most frequent words in a table and bar chart. If stop words dominate, compare results before and after stop word removal. 

• Compare at least two meaningful groups (e.g., spam vs ham, positive vs negative, recommended vs not recommended):  average text length, average word count and top 10 words for each group. 

• Provide at least five written insights. Each insight must include observation, evidence, and interpretation. **6\. Machine Learning \[4 Marks\]**   
Every approved dataset contains a usable label, so you have to build both a supervised model and a K-Means model. **6.1 Supervised Text Classification \[2.5 Marks\]** 

• Use the dataset label as the target (e.g., spam/ham or sentiment). 

• Split the data into training and test sets. Use stratification when appropriate. 

• Convert text to numerical features using TF-IDF. 

• Train at least ONE suitable classifier, such as Multinomial Naive Bayes or Logistic Regression. • Report accuracy and at least precision, recall and F1-score. Include a confusion matrix. 

• Interpret the results and mention at least one limitation. 

**6.2 K-Means Clustering \[1.5 Marks\]** 

• Apply K-Means to a meaningful numerical representation of the text (e.g., TF-IDF; dimensionality reduction such as  TruncatedSVD may be used if needed). 

• Choose k based on the dataset structure or an explained experiment; do NOT automatically force k=3 for every dataset. • Report the number of records in each cluster and calculate a clustering quality measure such as silhouette score when  applicable. 

• Inspect representative/top terms for each cluster and explain what each cluster seems to represent. • Compare the unsupervised clusters with the known labels at a high level. Do not expect cluster IDs to equal class IDs directly. 

**7\. Required Outputs and Deliverables \[2 Marks\]** 

• cleaned\_data.csv 

• At least four saved figures, including correlation heatmap, word-frequency chart, group comparison and model/confusion matrix figure. 

• model\_metrics.txt containing supervised-model results. 

• cluster\_summary.txt containing cluster sizes, quality measure and short interpretation. 

• README.md with setup, build, run, mount, Docker Hub and reproduction instructions. 

• Screenshots of successful docker build, docker images, running container and Jupyter notebook. • One ZIP containing the complete project. The dataset may be omitted only if redistribution is not allowed; in that case provide  exact download instructions.

Assignment \#1 \- Dockerized Data, Text Analysis and Machine Learning   
**Nile University \| CSCI461 Introduction to Big Data \| Fall 2026** 

**8\. Approved Dataset Options** 

| Dataset  | Content  | Link |
| ----- | :---- | ----- |
| 1\. SMS  Spam   Collection | Spam/ham SMS  messages  | https\://archive.ics.uci.edu/dataset/228/sms+spam+collection?utm\_source=chatgpt.com |
| 2\.  Sentiment   Labelled   Sentences | Positive/negative sentences from  Amazon, IMDb  and Yelp | https\://archive.ics.uci.edu/dataset/331/sentiment+labelled+sentencese? |
| 3\.  YouTube   Spam   Collection | YouTube  comments with  spam labels and  video groups | https\://archive.ics.uci.edu/dataset/380/youtube+spam+collection? |
| 4\. Twitter   US Airline   Sentiment | Tweets with  sentiment, airline  and negative   reason | https\://www\.kaggle.com/datasets/crowdflower/twitter-airline-sentiment/data |
| 5\.  Women's   E  Commerce  Clothing   Reviews | Review text \+   rating \+   recommendation  \+ age/category  fields | https\://www\.kaggle.com/datasets/nicapotato/womens-ecommerce-clothing-reviews |
| 6\. IMDb  Large   Movie   Review   Dataset | Large   positive/negative  review corpus | https\://www\.kaggle.com/datasets/lakshmi25npathi/imdb-dataset-of-50k-movie-reviews? |
| 7\. HCV   Data | Patient lab  values \+ age \+   sex \+ disease   category | https\://archive.ics.uci.edu/dataset/571/hcv+data? |
| 8\. Chronic   Kidney   Disease | Patient clinical  measurements  such as age,   blood pressure,  albumin, sugar,  hemoglobin,   creatinine,   hypertension,   diabetes, etc. | https\://archive.ics.uci.edu/dataset/336/chronic+kidney+disease? |

**10\. Bonus \[Up to \+1 Mark\]** 

• GitHub (+0.5): Publish the project in a well-organized repository with a useful README. 

• Model extension (+0.5): Compare two supervised classifiers OR add a justified model improvement such as n-grams,  hyperparameter tuning or dimensionality reduction. 

**11\. Discussion Expectations** 

**Each member may be asked to explain or modify any part of the project, including:** Dockerfile \-\> image \-\> container; image  layers; registry/repository; port mapping; bind mount vs volume; missing values/duplicates; loc/iloc; sampling; correlation; TF-IDF;  classification metrics; and why K-Means is unsupervised. 

**Dockerfile \-\> Custom Image \-\> Container \-\> Jupyter \-\> Data Cleaning \-\> Sampling \-\> Text Analysis \-\> TF-IDF \-\>  Classification \+ K-Means \-\> Persistent Outputs \-\> Docker Hub**

Assignment \#1 \- Dockerized Data, Text Analysis and Machine Learning 